require 'test_helper'

class EnrollmentTest < ActiveSupport::TestCase
  def setup
    @student = Student.create!(name: 'Student', surname: 'Test Surname', email: 'test@example.com', status: 10)
    @instructor = Instructor.create!(name: 'John', surname: 'Doe', email: 'instructor@test.com', status: 10)
    @course = Course.create!(name: 'Test Course', instructor: @instructor)
    @enrollment = Enrollment.new(student: @student, course: @course, grade: 5, status: 10)
  end

  test 'enrollment should belong to student' do
    assert_equal @student, @enrollment.student
  end

  test 'enrollment should belong to course' do
    assert_equal @course, @enrollment.course
  end
end
