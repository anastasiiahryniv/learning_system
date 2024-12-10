class EnrollmentMailer < ApplicationMailer
  def new_students_enrollment(instructor, course, student)
    @course = course
    @student = student
    mail(
      to: instructor.email,
      subject: course.name
    )
  end
end
