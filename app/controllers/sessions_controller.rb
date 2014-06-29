class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(username: params[:username])

    #if user exists and the password is correct
    if user && user.authenticate(params[:password])
      #store user id in cookie
      session[:user_id] = user.id
      flash[:notice] = "You've logged in!"
      redirect_to root_path
    else
      flash[:error] = "There's something wrong with your username or password."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've logged out!"
    redirect_to root_path
  end
end