require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe '#index' do
    let(:student) { create(:student) }
    let(:instructor) { create(:instructor) }

    it 'redirects to new student session path if no current student or instructor' do
      allow(controller).to receive(:current_student).and_return(nil)
      allow(controller).to receive(:current_instructor).and_return(nil)
      get :index
      expect(response).to redirect_to(new_student_session_path)
    end

    it 'does not redirect if current student is present' do
      allow(controller).to receive(:current_student).and_return(student)
      get :index

      expect(response).to_not redirect_to(new_student_session_path)
    end

    it 'does not redirect if current instructor is present' do
      allow(controller).to receive(:current_instructor).and_return(instructor)
      get :index

      expect(response).to_not redirect_to(new_student_session_path)
    end
  end
end
