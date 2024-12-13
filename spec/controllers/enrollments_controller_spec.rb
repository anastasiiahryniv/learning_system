require 'rails_helper'

RSpec.describe EnrollmentsController, type: :controller do
  let(:student) { create(:student) }
  let(:instructor) { create(:instructor) }
  let(:course) { create(:course) }
  let(:enrollment) { create(:enrollment, student:, course:) }

  before { sign_in student }

  describe '#index' do
    it 'lists all enrollments for the current student' do
      get :index

      expect(assigns(:enrollments)).to include(enrollment)
    end
  end

  describe '#create' do
    it 'creates a new enrollment if the student is not already enrolled' do
      expect do
        post :create, params: { course_id: course.id }
      end.to change(Enrollment, :count).by(1)
      expect(flash[:notice]).to eq(I18n.t('course_is_successfully_enrolled'))
    end

    it 'does not create a new enrollment if the student is already enrolled' do
      create(:enrollment, student:, course:)
      expect do
        post :create, params: { course_id: course.id }
      end.not_to change(Enrollment, :count)
      expect(flash[:alert]).to eq(I18n.t('course_is_already_enrolled'))
    end

    it 'redirects to the course after enrollment' do
      post :create, params: { course_id: course.id }
      expect(response).to redirect_to(course)
    end
  end
end
