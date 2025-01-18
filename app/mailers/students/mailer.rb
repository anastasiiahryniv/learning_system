module Students
  class Mailer < ApplicationMailer
    def course_start(course, student)
      @course = course
      @student = student
      mail(to: student.email, subject: course.name)
    end
  end
end
