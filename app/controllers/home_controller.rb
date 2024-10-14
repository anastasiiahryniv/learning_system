class HomeController < ApplicationController
  before_action :authenticate_student!, only: [:students]
  before_action :authenticate_instructor!, only: [:instructors]
  def index
    if current_student
      redirect_to home_students_path
    elsif current_instructor
      redirect_to home_instructors_path
    else
      redirect_to new_student_session_path
    end
  end

  private

  def students
  end

  def instructors
  end
end
