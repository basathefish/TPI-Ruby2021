class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash.now[:notice] = "Logged in successfully."
      redirect_to root_url
    else
      flash.now[:alert] = "There was something wrong with your login details."
      render 'new'
    end
  end

  def destroy
    # Remove the user id from the session
    @_current_user = session[:user_id] = nil
    flash[:notice] = "Logged out successfully."
    redirect_to login_path
  end
end
