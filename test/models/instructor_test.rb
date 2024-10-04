require 'test_helper'

class InstructorTest < ActiveSupport::TestCase
  test 'user should be valid' do
    @instructor = FactoryBot.create(:instructor)
    assert @instructor.valid?
  end

  test 'name should be present' do
    @instructor = FactoryBot.build(:instructor, name: '')
    assert_not @instructor.valid?
    assert_includes @instructor.errors[:name], "can't be blank"
  end
end
