require 'rails_helper'

RSpec.describe Course, type: :model do
  let(:student) { create :student }
  let(:student2) { create :student }
  let(:instructor) { create :instructor }
  let(:course) { create :course, instructor: }
  let(:enrollment) { create :enrollment, student:, course: }
  let(:enrollment2) { create :enrollment, student: student2, course: }

  describe 'course' do
    it 'is valid' do
      expect(course).to be_valid
    end

    it 'is invalid without name' do
      course.name = nil
      expect(course).not_to be_valid
      expect(course.errors[:name]).to include("can't be blank")
    end

    it 'is invalid when name and description are too long ' do
      course.name = 'a' * 101
      course.description = 'b' * 501
      expect(course).not_to be_valid
      expect(course.errors[:name]).to include('is too long (maximum is 100 characters)')
      expect(course.errors[:description]).to include('is too long (maximum is 500 characters)')
    end

    it 'should belong to instructor' do
      expect(instructor).to be course.instructor
    end

    it 'should be able to have many students' do
      expect(course.students).equal? student
      expect(course.students).equal? student2
    end

    it 'should be able to' do
      expect(course.enrollments).equal? enrollment
      expect(course.enrollments).equal? enrollment2
    end
  end

  describe '#set_status' do
    it 'sets the status after student created' do
      expect(course).to receive(:set_status)
      course.run_callbacks(:create)
    end
  end
end
