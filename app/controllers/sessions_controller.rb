class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(username: params[:username])

    #if user exists and the password is correct
    if user && user.authenticate(params[:password])
      if user.two_factor_auth?
        session[:two_factor] = true
        user.generate_pin!
        user.send_pin_to_twilio
        redirect_to pin_path
      else
        #store user id in cookie
        login_user!(user)
      end
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

  def pin
    if session[:two_factor].nil?
      flash[:error] = "Sorry you can't do that."
      redirect_to root_path
    end
    if request.post?
      user = User.find_by pin: params[:pin]
      if user
        session[:two_factor] = nil
        user.remove_pin!
        login_user!(user)
      else
        flash[:error] = "Sorry, something is wrong with your pin."
        redirect_to pin_path
      end
    end
  end

  private

  def login_user!(user)
    session[:user_id] = user.id
    flash[:notice] = "You've logged in!"
    redirect_to root_path
  end
end