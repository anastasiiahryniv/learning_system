class CommentPolicy < ApplicationPolicy
  include UserRoles
  class Scope < Scope
    def resolve
      if admin_instructor?
        scope.all
      elsif instructor? || student?
        scope.where(author: user)
      else
        scope.none
      end
    end
  end

  def update?
    user == record.author || (user.is_a?(Instructor) && user.instructor_admin?)
  end

  def destroy?
    update?
  end
end
