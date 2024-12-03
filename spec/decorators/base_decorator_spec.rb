require 'rails_helper'

RSpec.describe BaseDecorator do
  describe 'decorator' do
    let(:instructor) { create :instructor}
    let(:student) { create :student}
    let(:instructor_decorator) { instructor.decorate }
    let(:student_decorator) { student.decorate }

    describe '#full_name' do
      it 'returns the full name of the instructor' do
        expect(instructor_decorator.full_name).to eq("#{instructor.name} #{instructor.surname}")
      end

      it 'returns the full name of the student' do
        expect(student_decorator.full_name).to eq("#{student.name} #{student.surname}")
      end
    end
  end
end
