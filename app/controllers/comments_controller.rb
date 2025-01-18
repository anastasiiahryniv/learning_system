class CommentsController < ApplicationController
  before_action :set_course

  def create
    @comment = @course.comments.new(comment_params)

    @comment.student = current_student if current_student
    @comment.instructor = current_instructor if current_instructor

    if @comment.save
      redirect_to course_path(@course)
    else
      flash[:alert] = 'Comment has not been created'
      redirect_to course_path(@course)
    end
  end

  def update
    @comment = @course.comments.find(params[:id])
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to course_path(@course), notice: 'Comment was updated.' }
      else
        format.html { redirect_to course_path(@course), notice: 'Comment was not updated.' }
      end
    end
  end

  def destroy
    @comment = @course.comments.find(params[:id])
    @comment.destroy
    redirect_to course_path(@course)
  end

  private
  def set_course
    @course = Course.find(params[:course_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
