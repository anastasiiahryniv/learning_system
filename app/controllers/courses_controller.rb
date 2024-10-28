class CoursesController < ApplicationController
  before_action :set_course, only: %i[show edit update destroy]
  before_action :authenticate_instructor!

  def index
    @q = Course.ransack(params[:q])
    @courses = @q.result(distinct: true).where(instructor_id: current_instructor.id)
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
    @course.destroy
    redirect_to courses_path
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :description, :status)
  end
end
