require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get sign_in page if user is not signed in' do
    get new_student_session_path
    assert_response :success
  end
end
