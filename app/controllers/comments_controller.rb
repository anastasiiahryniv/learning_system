class CommentsController < ApplicationController
  # rescue_from CustomValidationError, with: :handle_custom_validation_error
  before_action :find_course
  before_action :find_comment, only: %i[update destroy]
  before_action :set_body_param, only: %i[create update]

  def create
    if validate_comment(@body)
      service = CommentCreationService.new(comment_params, @course, pundit_user)
      flash[:notice] = service.call ? I18n.t('comment_is_successfully_added') : I18n.t('comment_is_not_added')
    end

    redirect_to course_path(@course)
  end

  def update
    if validate_comment(@body) && @comment.update(comment_params)
      flash[:notice] = I18n.t('comment_is_successfully_updated')
    else
      flash[:alert] ||= I18n.t('comment_update_failed')
    end
    redirect_to course_path(@course)
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

  def set_body_param
    @body = ActionController::Base.helpers.strip_tags(params.dig(:comment, :body))
  end

  def validate_comment(body)
    CommentHandler::CommentsLengthError.validate_comment_length(body)
    true
  rescue CommentHandler::CommentsLengthError => e
    flash[:alert] = e.message
    false
  end
end
