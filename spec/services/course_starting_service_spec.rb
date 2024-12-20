require 'rails_helper'

RSpec.describe CourseStartingService, type: :model do
  let(:course) { create(:course) }
  let(:student) { create(:student) }
  let(:service) { CourseStartingService.new(course) }

  describe '#call' do
    it 'starts the course if it is inactive and has enrolled students' do
      allow(course).to receive(:may_start?).and_return(true)
      allow(course).to receive(:students).and_return([student])

      expect(course).to receive(:start)
      expect(Mailers::StartCourseMailer).to receive(:course_start).with(course, student).and_call_original

      service.call
    end

    it 'does not start the course if it is not inactive' do
      allow(course).to receive(:may_start?).and_return(false)

      expect(course).not_to receive(:start)
      expect(Mailers::StartCourseMailer).not_to receive(:course_start)

      service.call
    end

    it 'does not start the course if there are no enrolled students' do
      allow(course).to receive(:inactive?).and_return(true)
      allow(course).to receive(:has_students?).and_return(false)

      expect(course).not_to receive(:start)
      expect(Mailers::StartCourseMailer).not_to receive(:course_start)

      service.call
    end

    it 'sends an email to each enrolled student' do
      allow(course).to receive(:may_start?).and_return(true)
      students = [student, create(:student)]
      allow(course).to receive(:students).and_return(students)

      expect(course).to receive(:start)
      students.each do |student|
        expect(Mailers::StartCourseMailer).to receive(:course_start).with(course, student).and_call_original
      end

      service.call
    end
  end
end
