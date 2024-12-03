class StudentsController < ApplicationController
  before_action :set_current_student
  def index
    @student = @student.decorate
    @enrollments = @student.enrollments.includes(:course)
  end

  def show
  end

  private

  def set_current_student
    @student = Student.find_by(id: current_student.id)
  end
end
