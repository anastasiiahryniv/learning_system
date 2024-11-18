class CourseCreationService
  def initialize(params, instructor_id, controller, tags)
    @params = params
    @instructor_id = instructor_id
    @controller = controller
    @tags = tags
  end

  def create_course
    course.tap do |c|
      if c.save
        @controller.flash[:notice] = I18n.t('course_create_success')
        @controller.redirect_to @controller.course_path(c)
        mailer(c.instructor.id, c.id)
        create_or_delete_course_tags(c, @tags)
      else
        @controller.flash.now[:alert] = I18n.t('course_create_failed')
        @controller.render :new
      end
    end
  end

  private

  def course
    Course.new(@params.merge(instructor_id: @instructor_id))
  end

  def mailer(sender_id, course_id)
    Course::NewCourseEmailJob.perform_async(sender_id, course_id)
  end

  def create_or_delete_course_tags(course, tags)
    course.taggables.destroy_all
    (tags || '').split(',').map(&:strip).each do |tag|
      course.tags << Tag.find_or_create_by(name: tag)
    end
  end
end
