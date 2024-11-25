require 'rails_helper'

RSpec.describe CourseUpdatingService, type: :model do
  let(:course) { create(:course) }
  let(:instructor) { create(:instructor) }
  let(:valid_params) { attributes_for(:course) }
  let(:invalid_params) { valid_params.update(name: nil) }
  let(:service) { CourseUpdatingService.new(course, valid_params, flash) }

  describe '#call' do
    it 'updates the course with valid parameters' do
      service.call
      expect(course.reload.name).to eq(valid_params[:name])
    end

    it 'does not update the course with invalid parameters' do
      service = CourseUpdatingService.new(course, invalid_params, flash)
      service.call
      expect(course.reload.name).not_to be_nil
    end
  end
end
