require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  test 'user should be valid' do
    @student = FactoryBot.create(:student)
    assert @student.valid?
  end

  test 'name should be present' do
    @student = FactoryBot.build(:student, name: '')
    assert_not @student.valid?
    assert_includes @student.errors[:name], "can't be blank"
  end
end
