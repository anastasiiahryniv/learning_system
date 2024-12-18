class CourseStartingService
  def initialize(course)
    @course = course
  end

  def call
    return unless @course.inactive?
    return unless @course&.students_enrolled?

    @course.started!
    @course.students.each do |student|
      Mailers::StartCourseMailer.course_start(@course, student).deliver_now
    end
  end
end
