require 'rails_helper'

RSpec.describe Instructor, type: :model do
  let(:instructor) { create :instructor }

  describe 'instructor' do
    describe 'database columns' do
      it { is_expected.to have_db_column(:name).of_type(:string) }
      it { is_expected.to have_db_column(:surname).of_type(:string) }
      it { is_expected.to have_db_column(:email).of_type(:string) }
      it { is_expected.to have_db_column(:status).of_type(:string) }
    end

    describe 'associations' do
      it { is_expected.to have_many(:courses).dependent(:destroy) }
    end

    describe 'validations' do
      subject { build(:instructor) }

      it { is_expected.to be_valid }
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:surname) }
      it { is_expected.to validate_length_of(:name).is_at_most(Instructor::MAX_NAME_LENGTH) }
      it { is_expected.to validate_length_of(:surname).is_at_most(Instructor::MAX_NAME_LENGTH) }
    end

    describe '#avatar' do
      subject { build(:instructor).avatar }

      it { is_expected.to be_an_instance_of(ActiveStorage::Attached::One) }
      it { expect(instructor.avatar).to be_attached }
    end
  end
end
