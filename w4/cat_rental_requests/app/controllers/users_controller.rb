class UsersController < ApplicationController
  before_action :redirect_logged_in_user, only: [:new]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["Couldn't create account"]
      render :new
    end
  end

  def show
    @user = current_user
    render :show
  end
end
