class CoursesController < ApplicationController
  before_action :set_course, only: %i[show edit update destroy]
  before_action :authorize_policy

  def index
    @q = Course.ransack(params[:q])
    @courses = policy_scope(@q.result(distinct: true))
  end

  def show
  end

  def new
    @course = Course.new
  end

  def edit
  end

  def create
    CourseCreationService.new(course_params, current_instructor.id, self).create_course
  end

  def update
    CourseUpdatingService.new(@course, course_params, self).update_course
  end

  def destroy
    CourseDeletionService.new(@course, self).delete
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :description, :status)
  end

  def authorize_policy
    authorize(Course)
  end

  def permitted_course
    policy_scope(Course)
  end
end
