class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.is_a?(Instructor) && user.instructor_admin?
        scope.all
      elsif user.is_a?(Student) || (user.is_a?(Instructor) && !user.instructor_admin?)
        scope.where(authorable: user)
      else
        scope.none
      end
    end
  end

  def update?
    user == record.authorable || (user.is_a?(Instructor) && user.instructor_admin?)
  end

  def destroy?
    update?
  end
end
