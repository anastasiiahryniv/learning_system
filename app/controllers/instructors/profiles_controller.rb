module Instructors
  class ProfilesController < ApplicationController
    before_action :set_current_instructor

    def show
      @instructor = @instructor.decorate
    end

    def edit
    end

    def update
    end

    private

    def set_current_instructor
      @instructor = Instructor.find_by(id: current_instructor.id)
    end
  end
end
