class CourseUpdatingService
  def initialize(course, params, flash)
    @course = course
    @params = params
    @flash = flash
  end

  def call
    if @course.update(@params)
      @flash[:notice] = I18n.t('course_update_success')
    else
      @flash.now[:alert] = I18n.t('course_update_failed')
    end
  end
end
