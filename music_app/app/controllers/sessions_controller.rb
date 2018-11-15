class SessionsController < ApplicationController
  def create
    #debugger
    user = current_user
    log_in_user!(user) if logged_in?
    redirect_to user_url(user)
  end

  def new
  end

end
