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

  test "Logging out should redirect user to Welcome index" do
    get :destroy
    assert_response :redirect
  end
end
