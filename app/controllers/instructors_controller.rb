class InstructorsController < ApplicationController
  before_action :set_current_instructor
  def index
    @instructor = @instructor.decorate
  end

  private

  def set_current_instructor
    @instructor = Instructor.find_by(id: current_instructor.id)
  end
end
