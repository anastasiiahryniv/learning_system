class CoursesController < ApplicationController
  before_action :set_course, only: %i[show edit update destroy]
  before_action :authorize_policy

  def index
    @q = Course.ransack(params[:q])
    query = CoursesQuery.new(relation: @q.result(distinct: true).includes(:tags), params: filter_params).call
    @courses = query.page(params[:page]).decorate
  end

  def show
  end

  def new
    @course = Course.new
  end

  def edit
  end

  def create
    service = CourseCreationService.new(course_params, current_instructor.id, params[:course][:tags])
    if service.call
      @course = service.course
      flash[:notice] = I18n.t('course_create_success')
      redirect_to course_path(@course)
    else
      flash[:notice] = I18n.t('course_create_failed')
      render :new
    end
  end

  def update
    service = CourseUpdatingService.new(@course, course_params, flash)
    if service.call
      redirect_to course_path(@course)
    else
      render :edit
    end
  end

  def destroy
    @course.destroy
    redirect_to courses_path
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :description, :status, :tags)
  end

  def authorize_policy
    authorize(Course)
  end

  def permitted_course
    policy_scope(Course)
  end

  def filter_params
    params.permit(:search, :sort_by, :tag)
  end
end
