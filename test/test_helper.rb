ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...
  def registered_user
    user = User.new(username: 'registered_user', password: '12345', password_digest: BCrypt::Password.create('12345'))
    user.key = 'user-1'
    user
  end
  
  def login_as(user_key)
    session[:current_user_key] = user_key
  end
  
  def log_out_current_user
    session.delete(:current_user_key)
  end
end

def sample_discussion
  forum = sample_forum
  user = registered_user
  post = sample_new_post
  discussion = Discussion.new
  discussion.initialize_from_post(post)
  discussion
end

def sample_forum
  forum = Forum.new(name: 'Distributed Systems Discussions')
  forum.key = 'forum-1'
  forum
end

def sample_new_post_params
  post_params = { 
    name: 'Test post that starts a new discussion',
    body: 'Test post contents are updated via unit tests, do not be alarmed.'
  }
end

def sample_new_post
  forum = sample_forum
  user = registered_user
  test_post_key = 'post-123'
  forum_post = ForumPost.new(sample_new_post_params)
  forum_post.key = test_post_key
  forum_post.forum = forum
  forum_post.author = user
  forum_post.discussion_key = test_post_key
  forum_post
end
