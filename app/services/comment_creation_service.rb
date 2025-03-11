class CommentCreationService
  attr_reader :params, :course, :comment

  def initialize(params, course, user)
    @params = params
    @course = course
    @user = user
  end

  def call
    Comment.transaction do
      @comment = @course.comments.new(@params)
      @comment.course = @course
      @comment.parent_id = @params[:parent_id] if @params[:parent_id].present?
      @comment.author = @user

      @comment.save!
    end

    send_mail(@comment, @course.instructor)
    @comment
  end

  private

  def send_mail(comment, instructor_id)
    if @user.is_a?(Student)
      Instructors::Mailer.course_comment(comment, instructor_id).deliver_now
    end
  end
end
