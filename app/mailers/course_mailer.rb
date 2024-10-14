class CourseMailer < ApplicationMailer
  def new_course_created(instructor, course)
    @course = course
    mail(
      to: instructor.email,
      subject: course.name
    )
  end
end
