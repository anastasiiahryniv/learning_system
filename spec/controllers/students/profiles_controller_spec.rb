require 'rails_helper'

RSpec.describe Students::ProfilesController, type: :controller do
  let(:student) { create(:student) }
  let(:course) { create(:course) }
  let(:enrollment) { create(:enrollment, student:, course:) }

  before { sign_in student }

  describe '#show' do
    it 'shows the student profile with enrollments' do
      get :show
      expect(assigns(:student)).to eq(student.decorate)
      expect(assigns(:enrollments)).to include(enrollment)
    end

    it 'renders the edit template' do
      get :edit
      expect(response).to render_template(:edit)
    end
  end

  describe '#update' do
    it 'updates the student profile with valid attributes' do
      patch :update, params: { student: { name: 'New Name', surname: 'New Surname' } }
      student.reload
      expect(student.name).to eq('New Name')
      expect(student.surname).to eq('New Surname')
      expect(response).to redirect_to(students_profiles_path)
      expect(flash[:notice]).to eq('Profile was successfully updated.')
    end

    it 'does not update the student profile with invalid attributes' do
      patch :update, params: { student: { name: '', surname: '' } }
      expect(response).to render_template(:edit)
      expect(flash[:alert]).to eq("Name can't be blank, Surname can't be blank")
    end
  end
end
