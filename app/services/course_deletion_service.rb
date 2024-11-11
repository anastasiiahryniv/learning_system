class CourseDeletionService
  def initialize(course, flash)
    @course = course
    @flash = flash
  end

  def delete
    if @course.destroy
      @flash[:notice] = I18n.t 'course_deletion_success'
    else
      @flash[:alert] = I18n.t 'course_deletion_failed'
    end
  end
end
