class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    user = User.find_by_credentials(params[:user][:email], params[:user][:password])
    user ? user : nil
  end

  def logged_in?
    current_user.session_token == session[:session_token]
  end

  def log_in_user!(user)
    session[:session_token] = user.reset_session_token!
  end
end
