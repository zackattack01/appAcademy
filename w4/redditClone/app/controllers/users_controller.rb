class UsersController < ApplicationController
  before_action :redirect_if_logged_in, only: [:new, :create]

  def create
    @user = User.new(user_params)

    if @user.save
      login!(@user)
      redirect_to "/"
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def index
    ##TODO includes maybe
    @users = User.all
    render json: @users
  end

  def show
    @user = User.where(id: params[:id]).includes(subs: :posts).first
  end


end
