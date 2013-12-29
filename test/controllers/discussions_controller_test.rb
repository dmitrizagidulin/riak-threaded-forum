require 'test_helper'

class DiscussionsControllerTest < ActionController::TestCase
  setup do
    @forum = sample_forum
  end
  
  test "should get new" do
    # Not logged in
    get :new, { :forum_id => @forum.key }
    assert_redirected_to login_path
    # Logged in
    login_as(registered_user.key)
    get :new, { :forum_id => @forum.key }
    assert_not_nil assigns(:current_user)
    assert_not_nil assigns(:forum_post)
    assert_not_nil assigns(:forum)
    assert_response :success
  end
  
  test "should show discussion" do
    @discussion = sample_discussion
    get :show, { :forum_id => @forum.key, id: @discussion  }
    assert_not_nil assigns(:discussion)
    assert_not_nil assigns(:forum)
    assert_not_nil assigns(:posts)
    assert_response :success
  end
end
