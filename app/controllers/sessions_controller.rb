class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_email(params[:email])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to '/'
    else
      @error = "Incorrect email and/or password"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    render '/login'
  end

end
