require 'test_helper'

class ForumPostsControllerTest < ActionController::TestCase
  setup do
    @forum = Forum.new(name: 'Distributed Systems Discussions')
    @forum.key = 'forum-1'
    @forum_post = ForumPost.new name: 'Test Post'
    @forum_post.key = 'post-123'
    @forum_post.body = 'Test post contents are updated via unit tests, do not be alarmed.'
    @forum_post
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:forum_posts)
  end

  test "should get new" do
    login_as(registered_user.key)
    get :new, {:forum_key => @forum.key }
    assert_not_nil assigns(:forum), "A post can only be made to a forum"
    assert_not_nil assigns(:current_user)
    assert_response :success
  end

  test "should reply to a post" do
    login_as(registered_user.key)
    get :reply, {:reply_to_post => @forum_post.key }
    assert_not_nil assigns(:forum), "A post can only be made to a forum"
    assert_not_nil assigns(:current_user)
    assert_not_nil assigns(:reply_to_post)
    assert_response :success
  end
  
#  test "should create forum_post" do
#    post :create, forum_post: {  }
#
#    assert_redirected_to forum_post_path(assigns(:forum_post))
#  end

  test "should show forum_post" do
    get :show, id: @forum_post
    assert_not_nil assigns(:forum), "A post can only be made to a forum"
    assert_not_nil assigns(:author_name)
    assert_response :success
  end

  test "should get edit" do
    login_as(registered_user.key)
    get :edit, id: @forum_post
    assert_not_nil assigns(:forum)
    assert_not_nil assigns(:current_user)
    assert_response :success
  end

#  test "should update forum_post" do
#    patch :update, id: @forum_post, forum_post: {  }
#    assert_redirected_to forum_post_path(assigns(:forum_post))
#  end
#
#  test "should destroy forum_post" do
#    assert_difference('ForumPost.count', -1) do
#      delete :destroy, id: @forum_post
#    end
#
#    assert_redirected_to forum_posts_path
#  end
end
