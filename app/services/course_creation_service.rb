class CourseCreationService
  attr_reader :params, :instructor, :course

  def initialize(params, instructor_id, tags)
    @params = params
    @instructor_id = instructor_id
    @tags = tags
  end

  def call
    Course.transaction do
      @course = course_build
      @course.save!
      create_course_tags(@course, @tags)
    end

    send_mail(@instructor_id, @course.id)
    @course
  end

  private

  def course_build
    Course.new(@params.merge(instructor_id: @instructor_id).except(:tags))
  end

  def send_mail(sender_id, course_id)
    Course::NewCourseEmailJob.perform_async(sender_id, course_id)
  end

  def create_course_tags(course, tags)
    (tags || '').split(',').map(&:strip).each do |tag|
      course.tags << Tag.find_or_create_by(name: tag)
    end
  end
end
