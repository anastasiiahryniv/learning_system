module Instructors
  class Mailer < ApplicationMailer
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
    
    def course_comment(comment, instructor)
      @comment = comment
      @instructor = instructor
      mail(to: instructor.email, subject: I18n.t('new_comment_added'))
    end
  end
end
