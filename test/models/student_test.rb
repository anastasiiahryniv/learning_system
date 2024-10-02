require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  def setup
    @student_params = { name: 'John', surname: 'Doe', email: 'student@test.com' }
  end

  test 'user should be valid' do
    student = Student.new(@student_params)
    assert student.valid?
  end

  test 'name should be present' do
    student = Student.new(@student_params.except(:name))
    assert_not student.valid?
  end
end
