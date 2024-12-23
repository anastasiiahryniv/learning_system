class Course::NewCourseEmailJob
  include Sidekiq::Job

  def perform(instructor_id, course_id)
    instructor = Instructor.find(instructor_id)
    course = Course.find(course_id)
    Instructors::InstructorsMailer.new_course_created(instructor, course).deliver_now
  end
end
