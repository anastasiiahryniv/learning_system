module UserRoles
  def admin_instructor?
    user.is_a?(Instructor) && user.instructor_admin?
  end

  def instructor?
    user.is_a?(Instructor) && user.instructor?
  end

  def student?
    is_a?(Student)
  end
end
