class CourseUpdatingService
  def initialize(course, params, controller)
    @course = course
    @params = params
    @controller = controller
  end

  def update_course
    if @course.update(@params)
      @controller.flash[:notice] = I18n.t('course_update_success')
      @controller.redirect_to @controller.course_path(@course)
    else
      @controller.flash.now[:alert] = I18n.t('course_update_failed')
      @controller.render :edit
    end
  end
end
