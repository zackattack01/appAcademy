class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: [:new, :create]

  def new
    ## dummy user maybe?
    render :new
  end

  def create
    user = User.find_by_credentials(user_params[:username], user_params[:password])
    if user
      login!(user)
      redirect_to "/"
    else
      flash.now[:errors] = ["Invalid login credentials"]
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end
end
