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
    end

    private

    def set_current_student
      @student = Student.find_by(id: current_student.id)
    end
  end
end
