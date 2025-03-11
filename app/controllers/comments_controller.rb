class CommentsController < ApplicationController
  before_action :find_course
  before_action :find_comment, only: %i[update destroy]

  def create
    service = CommentCreationService.new(comment_params, @course, pundit_user)
    if service.call
      @comment = service.comment
      flash[:notice] = I18n.t('comment_is_successfully_added')
    else
      flash[:alert] = I18n.t('comment_is_not_added')
    end
    redirect_to course_path(@course)
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        flash[:notice] = I18n.t('comment_is_successfully_updated')
        format.html { redirect_to course_path(@course) }
      else
        format.html { redirect_to course_path(@course), flash[:notice] = I18n.t('comment_update_failed') }
      end
    end
  end

  def destroy
    @comment.destroy
    redirect_to course_path(@course)
  end

  private

  def find_course
    @course = Course.find(params[:course_id])
  end

  def find_comment
    @comment = @course.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:parent_id, :body).merge(author: pundit_user)
  end
end
