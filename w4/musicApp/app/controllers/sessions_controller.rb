class SessionsController < ApplicationController

	def new
		@user = User.new
		render :new
	end

	def create
		@user = User.find_by_credentials(user_params[:email], 
																		 user_params[:password])
		if @user
			login!(@user)
			flash[:notice] = "Welcome, #{@user.email}"
			redirect_to user_url(@user)
		else
			flash[:errors] = ["Invalid login credentials"]
			render :new
		end
	end

	def destroy
		user = current_user
		logout!(user)
		redirect_to new_session_url
	end
end
