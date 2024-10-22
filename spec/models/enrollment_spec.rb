require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  let(:enrollment) { create :enrollment }

  describe 'course' do
    subject { build(:enrollment) }

    describe 'database columns' do
      it { is_expected.to have_db_column(:status).of_type(:integer) }
      it { is_expected.to have_db_column(:grade).of_type(:integer) }
    end

    describe 'associations' do
      it { is_expected.to belong_to(:student)}
      it { is_expected.to belong_to(:course)}
    end

    describe 'validations' do
      it { is_expected.to be_valid }
      it { is_expected.to validate_presence_of(:grade) }
      it { is_expected.to validate_numericality_of(:grade).is_greater_than_or_equal_to(Enrollment::MIN_GRADE) }
      it { is_expected.to validate_numericality_of(:grade).is_less_than_or_equal_to(Enrollment::MAX_GRADE) }
    end
  end
end
