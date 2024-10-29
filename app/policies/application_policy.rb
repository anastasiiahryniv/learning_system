# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :instructor, :course

  def initialize(instructor, course)
    @instructor = instructor
    @course = course
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end
end
