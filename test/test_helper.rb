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

def sample_forum
  forum = Forum.new
  forum.key = 'forum-1'
  forum
end

def sample_new_post
  forum = sample_forum
  user = registered_user
  forum_post = ForumPost.new name: 'Test Post'
  forum_post.key = 'post-123'
  forum_post.forum_key = forum.key
  forum_post.created_by = user.key
  forum_post.body = 'Test post contents are updated via unit tests, do not be alarmed.'
  forum_post
end
