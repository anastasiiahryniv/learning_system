require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  def setup
    @instructor = Instructor.create!(name: 'Test', surname: 'Test Surname', email: 'test@example.com', status: 10)
    @student1 = Student.create!(name: 'Student 1', surname: 'Test Surname', email: 'test1@example.com', status: 10)
    @student2 = Student.create!(name: 'Student 2', surname: 'Test Surname', email: 'test2@example.com', status: 10)
    @course = Course.create!(name: 'Test Course', instructor: @instructor)
    @enrollment1 = Enrollment.create!(student: @student1, course: @course, grade: 5, status: :active)
    @enrollment2 = Enrollment.create!(student: @student2, course: @course, grade: 6, status: :active)
  end

  test 'course should belong to instructor' do
    assert_equal @instructor, @course.instructor
  end

  test 'course should have many students through enrollments' do
    assert_includes @course.students, @student1
    assert_includes @course.students, @student2
  end

  test 'course should have many enrollments' do
    assert_includes @course.enrollments, @enrollment1
    assert_includes @course.enrollments, @enrollment2
  end
end
