require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "Following the /login link should result in login form" do
    get :new
    assert_response :success
  end

  test "Logging in with empty username/password should redirect user to /login" do
    post :create, user: {}
    assert_redirected_to login_path
  end

  test "Logging in with valid username/password should redirect user to /home" do
    post :create, user: { username: 'registered_user', password: '12345' }
    assert_redirected_to user_home_index_path
  end
  
  test "Logging out should redirect user to Welcome index" do
    get :destroy
    assert_redirected_to welcome_index_path
  end
end
