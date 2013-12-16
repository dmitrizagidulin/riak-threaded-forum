require 'test_helper'

class ForumsControllerTest < ActionController::TestCase
  setup do
    @forum = Forum.new(name: 'Distributed Systems Discussions')
    @forum.key = 'forum-1'
    @forum
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:forums)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

#  test "should create forum" do
#    post :create, forum: { name: 'Test name' }
#
#    assert_redirected_to forum_path(assigns(:forum))
#  end

  test "should show forum" do
    get :show, id: @forum
    assert_not_nil assigns(:posts)
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @forum
    assert_response :success
  end

  test "should update forum" do
    patch :update, id: @forum, forum: { name: 'Massively Distributed Systems Discussions' }
    assert_redirected_to forum_path(assigns(:forum))
  end

#  test "should destroy forum" do
#    delete :destroy, id: TEST_FORUM_ID
#
#    assert_redirected_to forums_path
#  end
end
