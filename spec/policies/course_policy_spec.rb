require 'rails_helper'

RSpec.describe CoursePolicy do
  subject { CoursePolicy.new(user, course) }

  let(:course) { FactoryBot.create(:course) }

  context 'for instructor admin' do
    let(:user) { FactoryBot.create(:instructor, role: 20) }

    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.not_to permit_action(:create) }
    it { is_expected.not_to permit_action(:new) }
    it { is_expected.not_to permit_action(:update) }
    it { is_expected.to permit_action(:destroy) }
  end

  context 'for instructor (non admin)' do
    let(:user) { FactoryBot.create(:instructor, role: 10) }

    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:new) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.not_to permit_action(:destroy) }
  end

  context 'for student' do
    let(:user) { FactoryBot.create(:student) }

    it { is_expected.to permit_action(:index) }
    it { is_expected.not_to permit_action(:show) }
    it { is_expected.not_to permit_action(:create) }
    it { is_expected.not_to permit_action(:new) }
    it { is_expected.not_to permit_action(:update) }
    it { is_expected.not_to permit_action(:destroy) }
  end
end
