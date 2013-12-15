class SessionsController < ApplicationController
  # Displays the login form (to start new session)
  def new
    # Does nothing, just displays the login form at views/sessions/new.html.erb
  end

  # Attempts to log the user in, creates a new session
  # If login attempt is successful, set user in session and redirect to user_home#index
  # If not successful, kick back to /login and display error
  def create
    user = User.find_by_username(user_login_params[:username])
    if user and user.authenticate(user_login_params[:password])
      session[:current_user_key] = user.key
      redirect_to '/home'
    else
      redirect_to login_url, alert: "Invalid user/password combination" 
    end
  end

  # Logs out the user
  def destroy
    session.delete(:current_user_key)
    redirect_to welcome_index_path, alert: "Logged out."
  end
  
  private
    # Whitelist for user login parameters
    def user_login_params
      params.permit(:username, :password)
    end
end
