class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if admin_instructor?
        scope.all
      elsif instructor?
        scope.where(instructor_id: user.id)
      elsif student?
        scope.active
      end
    end
  end

  def index?
    user.is_a?(Instructor) || user.is_a?(Student)
  end

  def create?
    user.is_a?(Instructor) && user.instructor?
  end

  def show?
    index?
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

  def enroll?
    user.is_a?(Student)
  end

  def student_list?
    user.is_a?(Instructor)
  end

  def start?
    user.is_a?(Instructor)
  end
end
