module Instructors
  class InstructorsMailer < ApplicationMailer
    def new_course_created(instructor, course)
      @course = course
      mail(
        to: instructor.email,
        subject: course.name
      )
    end

    def new_students_enrollment(instructor, course, student)
      @course = course
      @student = student
      mail(
        to: instructor.email,
        subject: course.name
      )
    end
  end
end
