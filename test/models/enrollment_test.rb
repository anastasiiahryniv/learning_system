require 'test_helper'

class EnrollmentTest < ActiveSupport::TestCase
  def setup
    @student = FactoryBot.create(:student)
    @course = FactoryBot.create(:course, instructor: FactoryBot.create(:instructor))
    @enrollment = FactoryBot.create(:enrollment, student: @student, course: @course)
  end

  test 'enrollment should belong to student' do
    assert_equal @student, @enrollment.student
  end

  test 'enrollment should belong to course' do
    assert_equal @course, @enrollment.course
  end
end
