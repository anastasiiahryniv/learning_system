class CommentsController < ApplicationController
  before_action :set_course

  def create
    @comment = @course.comments.create(comment_params)
    # @comment.user = current_user
    if @comment.save
      redirect_to course_path(@course)
    else
      flash[:alert] = 'Comments has not been created'
      redirect_to course_path(@course)
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
