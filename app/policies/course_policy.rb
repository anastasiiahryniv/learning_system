class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.is_a?(Instructor) && user.instructor_admin?
        scope.all
      elsif user.is_a?(Instructor) && user.instructor?
        scope.where(instructor_id: user.id)
      elsif user.is_a?(Student)
        scope.where(status: 20)
      end
    end
  end

  def index?
    user.is_a?(Instructor) || user.is_a?(Student)
  end

  def create?
    user.is_a?(Instructor) && user.instructor?
  end

  def new?
    create?
  end

  def update?
    create?
  end

  def destroy?
    user.is_a?(Instructor) && user.instructor_admin?
  end
end
