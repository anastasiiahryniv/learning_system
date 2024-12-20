class CourseStartingService
  def initialize(course)
    @course = course
  end

  def call
    return false unless @course.may_start?

    @course.start
    send_notification_to_students

    true
  end

  def send_notification_to_students
    @course.students.each do |student|
      Mailers::StartCourseMailer.course_start(@course, student).deliver_now
    end
  end
end
