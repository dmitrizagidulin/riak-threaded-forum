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
