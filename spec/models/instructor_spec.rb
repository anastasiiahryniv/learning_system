require 'rails_helper'

RSpec.describe Instructor, type: :model do
  let(:instructor) { create :instructor }

  describe 'instructor' do
    it 'is valid' do
      expect(instructor).to be_valid
    end

    it 'is invalid without name || surname || email ' do
      instructor.name = nil
      instructor.surname = nil
      instructor.email = nil
      expect(instructor).not_to be_valid
      expect(instructor.errors[:name]).to include("can't be blank")
      expect(instructor.errors[:surname]).to include("can't be blank")
      expect(instructor.errors[:email]).to include("can't be blank")
    end

    it 'is invalid if surname is longer than 50 characters' do
      instructor.name = 'a' * 51
      instructor.surname = 'b' * 51
      expect(instructor).not_to be_valid
      expect(instructor.errors[:name]).to include('is too long (maximum is 50 characters)')
      expect(instructor.errors[:surname]).to include('is too long (maximum is 50 characters)')
    end

    it 'is invalid already existing an email' do
      instructor2 = build :instructor, email: instructor.email
      expect(instructor2).not_to be_valid
      expect(instructor2.errors[:email]).to include('has already been taken')
    end
  end

  describe '#set_status' do
    it 'sets the status after instructor created' do
      expect(instructor).to receive(:set_status)
      instructor.run_callbacks(:create)
    end
  end
end
