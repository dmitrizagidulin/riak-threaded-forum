require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "Following the /login link should result in login form" do
    get :new
    assert_response :success
  end

  test "Logging in should redirect user to /home" do
    get :create
    assert_response :redirect
  end

  test "Logging out should redirect user to Welcome index" do
    get :destroy
    assert_response :redirect
  end
end
