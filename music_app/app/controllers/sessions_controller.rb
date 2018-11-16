class SessionsController < ApplicationController
  before_action :require_log_in, except: [:create, :new]

  def create
    #debugger
    user = User.find_by_credentials(params[:user][:email], params[:user][:password])
    if user
      log_in_user!(user)
      redirect_to user_url(user)
    else
      flash.now[:errors] = ["Invalid login! Try again."]
      render :new
    end
  end

  def new
  end

  def destroy
    log_out!
    redirect_to new_session_url
  end

end
