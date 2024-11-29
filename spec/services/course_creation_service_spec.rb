require 'rails_helper'

RSpec.describe CourseCreationService, type: :model do
  let(:course) { create(:course) }
  let(:instructor) { create(:instructor) }
  let(:valid_params) { attributes_for(:course) }
  let(:invalid_params) { valid_params.update(name: nil) }
  let(:tags) { 'tag' }
  let(:service) { CourseCreationService.new(valid_params, instructor.id, tags) }

  describe '#call' do
    it 'creates a new course with valid parameters and tags' do
      expect { service.call }.to change(Course, :count).by(1)
      expect(service.course.tags.map(&:name)).to match_array(['tag'])
    end

    it 'sends an email after creating a course' do
      expect(Course::NewCourseEmailJob).to receive(:perform_async).with(instructor.id, course.id)
      service.send(:send_mail, instructor.id, course.id)
    end

    it 'raises an error with invalid parameters' do
      service = CourseCreationService.new(invalid_params, instructor.id, tags)
      expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'raises an error with missing tag' do
      service = CourseCreationService.new(invalid_params, instructor.id, nil)
      expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'does not create a course if transaction fails' do
      allow_any_instance_of(Course).to receive(:save!).and_raise(ActiveRecord::RecordInvalid)
      expect do
        service.call
      rescue StandardError
        nil
      end.not_to change(Course, :count)
    end
  end
end
