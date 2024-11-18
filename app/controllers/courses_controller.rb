class CoursesController < ApplicationController
  before_action :set_course, only: %i[show edit update destroy]
  before_action :authorize_policy

  def index
    @q = Course.ransack(params[:q])
    @courses = CoursesQuery.new(relation: @q.result(distinct: true), params: filter_params).call
  end

  def show
  end

  def new
    @course = Course.new
  end

  def edit
  end

  def create
    CourseCreationService.new(course_params.except(:tags), current_instructor.id, self,
                              params[:course][:tags]).create_course
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
