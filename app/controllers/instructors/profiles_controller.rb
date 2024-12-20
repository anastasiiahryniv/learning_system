module Instructors
  class ProfilesController < ApplicationController
    before_action :set_current_instructor

    def show
      @instructor = @instructor.decorate
    end

    def edit
    end

    def update
      if @instructor.update(instructor_params)
        flash[:notice] = I18n.t('profile_update_success')
        redirect_to instructors_profiles_path
      else
        flash[:alert] = @instructor.errors.full_messages.join(', ')
        render :edit
      end
    end

    private

    def set_current_instructor
      @instructor = Instructor.find_by(id: current_instructor.id)
    end

    def instructor_params
      params.require(:instructor).permit(:name, :surname, :avatar)
    end
  end
end
