require 'rails_helper'

RSpec.describe Student, type: :model do
  let(:student) { create :student }

  describe 'student' do
    it 'is valid' do
      expect(student).to be_valid
    end

    it 'is invalid without name and surname ' do
      student.name = nil
      student.surname = nil
      student.email = nil
      expect(student).not_to be_valid
      expect(student.errors[:name]).to include("can't be blank")
      expect(student.errors[:surname]).to include("can't be blank")
      expect(student.errors[:email]).to include("can't be blank")
    end

    it 'is invalid if surname is longer than 50 characters' do
      student.name = 'a' * 51
      student.surname = 'b' * 51
      expect(student).not_to be_valid
      expect(student.errors[:name]).to include('is too long (maximum is 50 characters)')
      expect(student.errors[:surname]).to include('is too long (maximum is 50 characters)')
    end

    it 'is invalid already existing an email' do
      student2 = build :student, email: student.email
      expect(student2).not_to be_valid
      expect(student2.errors[:email]).to include('has already been taken')
    end
  end

  describe '#set_status' do
    it 'sets the status after student created' do
      expect(student).to receive(:set_status)
      student.run_callbacks(:create)
    end
  end
end
