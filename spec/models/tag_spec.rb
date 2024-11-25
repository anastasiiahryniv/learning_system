require 'rails_helper'

RSpec.describe Tag, type: :model do
  let(:tag) { create :tag }

  describe 'tag' do
    subject { build(:tag) }

    describe 'database columns' do
      it { is_expected.to have_db_column(:name).of_type(:string) }
    end

    describe 'associations' do
      it { is_expected.to have_many(:courses).through(:taggables) }
      it { is_expected.to have_many(:taggables).dependent(:destroy) }
    end

    describe 'validations' do
      it { is_expected.to be_valid }
      it { is_expected.to validate_presence_of(:name) }
    end
  end
end
