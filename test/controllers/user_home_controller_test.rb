require 'test_helper'

class UserHomeControllerTest < ActionController::TestCase
  test "non-logged in users should get redirected to login page" do
    get :index
    assert_redirected_to login_path
  end

end
