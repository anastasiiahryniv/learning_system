class EnrollmentsController < ApplicationController
  before_action :set_course, except: :index

  def index
    @enrollments = current_student.enrollments.includes(:course).page(params[:page])
  end

  def create
    if @course.students.include?(current_student)
      flash[:alert] = I18n.t('course_is_already_enrolled')
    else
      @course.enrollments.create(student: current_student)
      flash[:notice] = I18n.t('course_is_successfully_enrolled')
    end
    redirect_to @course
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end
end
