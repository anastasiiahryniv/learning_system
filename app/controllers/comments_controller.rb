class CommentsController < ApplicationController
  before_action :find_course

  def create
    @commentable = find_commentable
    @comment = @course.comments.new(comment_params)
    @comment.parent_id = params[:comment][:parent_id] if params[:comment][:parent_id].present?
    @comment = @commentable.comments.new(comment_params) if @commentable

    @comment.course = @course
    @comment.authorable = pundit_user

    if @comment.save
      Instructors::Mailer.course_comment(@comment, @course.instructor).deliver_now if current_student
    else
      flash[:notice] = I18n.t('comment_is_successfully_added')
    end
    redirect_to course_path(@course)
  end

  def update
    @comment = @course.comments.find(params[:id])
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to course_path(@course), flash[:notice] = I18n.t('comment_is_successfully_updated') }
      else
        format.html { redirect_to course_path(@course), flash[:notice] = I18n.t('comment_update_failed') }
      end
    end
  end

  def destroy
    @comment = @course.comments.find(params[:id])
    @comment.destroy
    redirect_to course_path(@course)
  end

  private

  def find_course
    @course = Course.find(params[:course_id])
  end

  def find_commentable
    return unless params[:comment][:commentable_type].present? && params[:comment][:commentable_id].present?

    params[:comment][:commentable_type].constantize.find_by(id: params[:comment][:commentable_id])
  end

  def comment_params
    params.require(:comment).permit(:body,
                                    :commentable_id,
                                    :commentable_type,
                                    :parent_id,
                                    :authorable_type,
                                    :authorable_id)
  end
end
