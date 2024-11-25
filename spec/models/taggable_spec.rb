require 'rails_helper'

RSpec.describe Taggable, type: :model do
  describe 'taggable' do
    describe 'associations' do
      it { is_expected.to belong_to(:course) }
      it { is_expected.to belong_to(:tag) }
    end
  end
end
