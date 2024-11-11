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
    @course = current_instructor.courses.build(course_params)

    sender = @course.instructor

    if @course.save
      Course::NewCourseEmailJob.perform_async(sender.id, @course.id)
      redirect_to course_path(@course)
    else
      render 'new'
    end
  end

  def update
    if @course.update(course_params)
      redirect_to course_path(@course)
    else
      render 'edit'
    end
  end

  def destroy
    CourseDeletionService.new(@course, flash).delete
    redirect_to courses_path
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
