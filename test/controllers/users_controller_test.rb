require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = registered_user
  end

  def teardown
    log_out_current_user
  end
  
  test "should get index" do
    # Not logged in
    get :index
    assert_redirected_to login_path
    # Logged in
    login_as(registered_user.key)
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    # Not logged in
    get :new
    assert_redirected_to login_path
    # Logged in
    login_as(registered_user.key)
    get :new
    assert_response :success
  end

  test "should show user" do
    # Not logged in
    get :show, id: @user
    assert_redirected_to login_path
    # Logged in
    login_as(registered_user.key)
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    # Not logged in
    get :edit, id: @user
    assert_redirected_to login_path
    # Logged in
    login_as(registered_user.key)
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
#    patch :update, id: @user, user: {  }
#    assert_redirected_to user_path(assigns(:user))
  end

end
