class CoursesController < ApplicationController
  before_action :find_course, only: %i[show edit update destroy]
  before_action :permitted_courses, only: [:index]
  before_action :authorize_policy

  def index
    query = CoursesQuery.new(relation: permitted_courses, params: filter_params,
                             student: current_student).call
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
    service = CourseUpdatingService.new(@course, course_params)
    if service.call
      flash[:notice] = I18n.t('course_update_success')
      redirect_to course_path(@course)
    else
      flash[:notice] = I18n.t('course_update_failed')
      render :edit
    end
  end

  def destroy
    @course.destroy
    redirect_to courses_path
  end

  private

  def find_course
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

  def permitted_courses
    @q = Course.ransack(params[:q])
    @q.result(distinct: true).includes(:tags)
  end
end
