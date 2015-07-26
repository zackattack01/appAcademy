class UsersController < ApplicationController
  before_action :redirect_unless_logged_in, only: :show

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private


  def redirect_unless_logged_in
    unless logged_in?
      redirect_to new_session_url
    end
  end
end
