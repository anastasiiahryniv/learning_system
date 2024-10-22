require 'rails_helper'

RSpec.describe Course, type: :model do
  let(:course) { create :course }

  describe 'course' do
    subject { build(:course) }

    describe 'database columns' do
      it { is_expected.to have_db_column(:name).of_type(:string) }
      it { is_expected.to have_db_column(:description).of_type(:text) }
      it { is_expected.to have_db_column(:status).of_type(:integer) }
    end

    describe 'associations' do
      it { is_expected.to have_many(:enrollments).dependent(:destroy) }
      it { is_expected.to have_many(:students).through(:enrollments) }
      it { is_expected.to belong_to(:instructor) }
    end

    describe 'validations' do
      it { is_expected.to be_valid }
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_length_of(:name).is_at_most(Course::MAX_COURSE_NAME_LENGTH) }
      it { is_expected.to validate_length_of(:description).is_at_most(Course::MAX_DESCRIPTION_LENGTH) }
    end
  end
end
