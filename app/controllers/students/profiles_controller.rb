module Students
  class ProfilesController < ApplicationController
    before_action :set_current_student

    def show
      @student = @student.decorate
      @enrollments = @student.enrollments.includes(:course)
    end

    def edit
    end

    def update
      if @student.update(student_params)
        redirect_to students_profiles_path, notice: 'Profile was successfully updated.'
      else
        flash[:alert] = @student.errors.full_messages.join(', ')
        render :edit
      end
    end

    private

    def set_current_student
      @student = Student.find_by(id: current_student.id)
    end

    def student_params
      params.require(:student).permit(:name, :surname, :avatar)
    end
  end
end
