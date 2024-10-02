require 'test_helper'

class InstructorTest < ActiveSupport::TestCase
  def setup
    @instructor_params = { name: 'John', surname: 'Doe', email: 'instructor@test.com' }
  end

  test 'user should be valid' do
    instructor = Student.new(@instructor_params)
    assert instructor.valid?
  end

  test 'name should be present' do
    instructor = Student.new(@instructor_params.except(:name))
    assert_not instructor.valid?
  end
end
