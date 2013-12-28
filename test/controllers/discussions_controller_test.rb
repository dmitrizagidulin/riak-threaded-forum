require 'test_helper'

class DiscussionsControllerTest < ActionController::TestCase
  setup do
    @forum = sample_forum
    @forum_post = sample_new_post
    @discussion = sample_discussion
  end

  test "should get new" do
    # Not logged in
    get :new, {:forum_key => @forum.key }
    assert_redirected_to login_path
    # Logged in
    login_as(registered_user.key)
    get :new, {:forum_key => @forum.key }
    assert_response :success
  end

  test "should show discussion" do
    get :show, id: @discussion
    assert_response :success
  end
end
