require 'rails_helper'

RSpec.describe Instructors::ProfilesController, type: :controller do
  let(:instructor) { create(:instructor) }

  before { sign_in instructor }

  describe '#show' do
    it 'shows the instructor profile with enrollments' do
      get :show
      expect(assigns(:instructor)).to eq(instructor.decorate)
    end

    it 'renders the edit template' do
      get :edit
      expect(response).to render_template(:edit)
    end
  end

  describe '#update' do
    it 'updates the instructor profile with valid attributes' do
      patch :update, params: { instructor: { name: 'New Name', surname: 'New Surname' } }
      instructor.reload
      expect(instructor.name).to eq('New Name')
      expect(instructor.surname).to eq('New Surname')
      expect(response).to redirect_to(instructors_profiles_path)
      expect(flash[:notice]).to eq('Profile was successfully updated.')
    end

    it 'does not update the instructor profile with invalid attributes' do
      patch :update, params: { instructor: { name: '', surname: '' } }
      patch :update, params: { instructor: { name: '', surname: '' } }
      expect(response).to render_template(:edit)
      expect(flash[:alert]).to eq("Name can't be blank, Surname can't be blank")
    end
  end
end
