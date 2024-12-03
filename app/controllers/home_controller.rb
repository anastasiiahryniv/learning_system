class HomeController < ApplicationController
  def index
    redirect_to new_student_session_path unless current_student || current_instructor
  end
end
