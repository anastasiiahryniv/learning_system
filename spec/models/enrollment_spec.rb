require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  let(:student) { create :student }
  let(:instructor) { create :instructor }
  let(:course) { create :course, instructor: }
  let(:enrollment) { create :enrollment, student:, course: }

  describe 'enrollment' do
    it 'is valid' do
      expect(enrollment).to be_valid
    end

    it 'is invalid without grade' do
      enrollment.grade = nil
      expect(enrollment).not_to be_valid
      expect(enrollment.errors[:grade]).to include("can't be blank")
    end

    it 'is invalid when grade is greater than MAX_GRADE' do
      enrollment.grade = 11
      expect(enrollment).not_to be_valid
      expect(enrollment.errors[:grade]).to include('must be less than or equal to 10')
    end

    it 'is invalid when grade is lower than MIN_GRADE' do
      enrollment.grade = 0
      expect(enrollment).not_to be_valid
      expect(enrollment.errors[:grade]).to include('must be greater than or equal to 1')
    end

    it 'should belong to student' do
      expect(student).to be enrollment.student
    end

    it 'should belong to course' do
      expect(course).to be enrollment.course
    end
  end
end
