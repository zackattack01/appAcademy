class UsersController < ApplicationController

	def new
		@user = User.new
		render :new
	end

	def create
		user = User.create!(user_params)
		if user.save
			login!(user)
			redirect_to user_url(user)
		else
			flash[:errors] = @user.errors.full_messages
			render :new
		end
	end

	def show
		@user = User.find(params[:id])
		render :show
	end

	def destroy
		
	end

	def update

	end

	def edit

	end
end
