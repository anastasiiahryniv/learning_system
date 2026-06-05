class EnrollmentsController < ApplicationController
  before_action :find_course, except: :index

  def index
    @enrollments = current_student.enrollments.includes(:course).page(params[:page])
    respond_to do |format|
      format.html
      format.csv do
        send_data Course.to_csv(@enrollments), filename: Date.today.to_s, content_type: 'text/csv'
      end
    end
  end

  def create
    if @course.students.include?(current_student)
      flash[:alert] = I18n.t('course_is_already_enrolled')
    else
      @course.enrollments.create(student: current_student)
      Instructors::Mailer.new_student_enrollment(@course.instructor, @course, current_student).deliver_now
      flash[:notice] = I18n.t('course_is_successfully_enrolled')
    end
    redirect_to @course
  end

  private

  def find_course
    @course = Course.find(params[:course_id])
  end
end
