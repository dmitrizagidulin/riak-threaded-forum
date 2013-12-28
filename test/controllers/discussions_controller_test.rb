require 'test_helper'

class DiscussionsControllerTest < ActionController::TestCase
  setup do
    @forum = sample_forum
    @forum_post = sample_new_post
    @discussion = sample_discussion
  end
  
  test "should show discussion" do
    get :show, id: @discussion
    assert_response :success
  end
end
