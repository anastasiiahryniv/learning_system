class CoursePolicy < ApplicationPolicy
  class Scope
    attr_reader :instructor, :scope

    def initialize(instructor, scope)
      @instructor = instructor
      @scope = scope
    end

    def resolve
      if instructor.instructor_admin?
        scope.all
      else
        scope.where(instructor_id: instructor.id)
      end
    end
  end

  def index?
    instructor.instructor? || instructor.instructor_admin?
  end

  def create?
    instructor.instructor?
  end

  def update?
    index?
  end

  def destroy?
    instructor.instructor_admin?
  end
end