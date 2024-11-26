require 'rails_helper'

RSpec.describe CourseDecorator do
  describe 'decorator' do
    let(:course) { create :course, name: 'a' * 50, description: 'b' * 50 }
    let(:decorator) { course.decorate }

    context '#truncated_name' do
      it 'returns the name truncated to 40 characters' do
        expect(decorator.truncated_name).to eq("#{'a' * 37}...")
      end
    end

    context '#truncated_description' do
      it 'returns the description truncated to 40 characters' do
        expect(decorator.truncated_description).to eq("#{'b' * 37}...")
      end
    end
  end
end
