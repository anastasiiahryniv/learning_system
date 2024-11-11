class CourseDeletionService
  def initialize(course, controller)
    @course = course
    @controller = controller
  end

  def delete
    if @course.destroy
      @controller.flash[:notice] = I18n.t('course_deletion_success')
      @controller.redirect_to @controller.courses_path
    else
      @controller.flash[:alert] = I18n.t('course_deletion_failed')
    end
  end
end
