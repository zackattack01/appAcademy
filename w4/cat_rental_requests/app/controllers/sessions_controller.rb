class SessionsController < ApplicationController
  before_action :redirect_logged_in_user, only: [:new]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(user_params)
    if @user
      log_in!(@user)
      flash[:notice] = "You've successfully logged in as #{@user.username}"
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["Invalid username/password combination"]
      render :new
    end
  end

  def destroy
    log_out!
    redirect_to login_url
  end
end
