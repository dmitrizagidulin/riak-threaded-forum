require 'test_helper'

class ForumPostsControllerTest < ActionController::TestCase
  setup do
    @forum = sample_forum
    @discussion = sample_discussion
    @forum_post = sample_new_post
  end

  test "should get index" do
    # Not logged in
    get :index
    assert_redirected_to login_path
    # Logged in
    login_as(registered_user.key)
    get :index
    assert_response :success
    assert_not_nil assigns(:forum_posts)
  end

#  test "should reply to a discussion" do
#    # Not logged in
#    get :new_reply_discussion, { :discussion_key => @discussion.key, :forum_key => @forum.key }
#    assert_redirected_to login_path
#    # Logged in
#    login_as(registered_user.key)
#    get :new_reply_discussion, { :discussion_key => @discussion.key, :forum_key => @forum.key }
#    assert_not_nil assigns(:forum)
#    assert_not_nil assigns(:current_user)
#    assert_not_nil assigns(:discussion)
#    assert_response :success
#  end
  
  test "should reply to a post" do
    # Not logged in
    get :new_reply_post, {:reply_to_post => @forum_post.key, :discussion_key => @discussion.key, :forum_key => @forum.key }
    assert_redirected_to login_path
    # Logged in
    login_as(registered_user.key)
    get :new_reply_post, {:reply_to_post => @forum_post.key, :discussion_key => @discussion.key, :forum_key => @forum.key }
    assert_not_nil assigns(:forum), "A post can only be made to a forum"
    assert_not_nil assigns(:current_user)
    assert_not_nil assigns(:discussion)
    assert_not_nil assigns(:reply_to_post)
    assert_response :success
  end

  test "should show forum_post" do
    get :show, { id: @forum_post, discussion_id: @discussion }
    assert_not_nil assigns(:discussion)
    assert_not_nil assigns(:forum), "A post can only be made to a forum"
    assert_not_nil assigns(:author_name)
    assert_response :success
  end

  test "should get edit" do
    # Not logged in
    get :edit, id: @forum_post
    assert_redirected_to login_path
    # Logged in
    login_as(registered_user.key)
    get :edit, id: @forum_post
    assert_not_nil assigns(:forum)
    assert_not_nil assigns(:current_user)
    assert_response :success
  end
end
