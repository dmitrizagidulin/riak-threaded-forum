require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  test "any user (logged in or not) should be able to view the home page" do
    get :index
    assert_response :success
  end

end
