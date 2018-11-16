class SessionsController < ApplicationController
  def create
    #debugger
    user = current_user
    log_in_user!(user) if logged_in?
    redirect_to user_url(user)
  end

  def new
  end

  def destroy
    log_out!
    redirect_to new_session_url
  end

end
