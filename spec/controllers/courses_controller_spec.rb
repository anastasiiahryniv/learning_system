require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  describe 'GET #index' do
    let(:student) { create(:student) }
    let(:instructor) { create(:instructor) }
    let(:course) { create(:course) }

    before do
      sign_in student
      allow(controller).to receive(:current_student).and_return(student)
    end

    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'paginates the courses' do
      get :index, params: { page: 1 }
      expect(assigns(:courses).object.current_page).to eq(1)
    end

    it 'filters courses based on search params' do
      get :index, params: { search: course.name }
      expect(assigns(:courses)).to include(course)
    end

    # it 'sorts courses by name by default' do
    #   create(:course, name: 'Beta')
    #   create(:course, name: 'Alpha')
    #
    #   get :index
    #   expect(assigns(:courses).map(&:name)).to eq(['Alpha', 'Beta'])
    # end

    it 'filters courses based on tag params' do
      tag = create(:tag)
      course.tags << tag
      get :index, params: { tag: tag.name }
      expect(assigns(:courses)).to include(course)
    end
  end

  describe 'POST #create' do
    let(:instructor) { create(:instructor) }
    let(:course_params) { attributes_for(:course) }

    before do
      sign_in instructor
      allow(controller).to receive(:current_instructor).and_return(instructor)
    end

    it 'creates a new course' do
      expect do
        post :create, params: { course: course_params }
      end.to change(Course, :count).by(1)
    end

    it 'redirects to the new course' do
      post :create, params: { course: course_params }
      expect(response).to redirect_to(course_path(assigns(:course)))
    end

    it 'renders new template on failure' do
      allow_any_instance_of(CourseCreationService).to receive(:call).and_return(false)
      post :create, params: { course: course_params }
      expect(response).to render_template(:new)
    end
  end
end
