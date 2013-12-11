class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user
  
  # Returns current logged in user or nil (session helper method)
  # @return [User, nil] current logged in user, or nil
  def current_user
    nil
  end
  
  # Returns true if a user is logged in, redirects to <tt>/login</tt> otherwise
  # Session helper method, for use with <tt>before_filter</tt> in login-protected controllers
  # @return [Boolean] +true+ if the user is logged in
  # Redirects the user to /login if not logged in
  def require_user
    return true unless current_user.nil?

    redirect_to login_path
  end
end
