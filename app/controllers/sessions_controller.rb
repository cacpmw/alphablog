class SessionsController < ApplicationController
  def new
  end

  def create

    user = User.find_by(email: params[:session][:email].downcase)
    if user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome back #{user.username}"
      redirect_to user_path(user)
    else
      flash[:warning] = 'Wrong Credentials'
      render 'new'
    end
  rescue NoMethodError
    flash.now[:warning] = 'Wrong Credentials'
    render 'new'

  rescue ActiveRecord::RecordNotFound
    flash.now[:warning] = 'Wrong Credentials'
    render 'new'
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path

  end


end
