class BandsController < ApplicationController
	before_action :require_logged_in_user

	def new
		@band = Band.new
		render :new
	end

	def create
		@band = Band.create!(band_params)
		if @band.save
			flash[:notice] = "Band created!"
			redirect_to band_url(@band)
		else
			flash[:errors] = ["Unable to save band :("]
			redirect_to bands_url
		end
	end

	def update
		@band = Band.find(params[:id])
		if @band.update(band_params)
			flash[:notice] = "band Updated!"
			redirect_to band_url(@band)
		else
			flash[:errors] = @band.full_error_messages
			render :edit
		end
	end

	def index
		@bands = Band.all
		render :index
	end

	def edit
		@band = Band.find(params[:id])
		render :edit
	end

	def show
		@band = Band.find(params[:id])
		render :show
	end

	def destroy
		@band = Band.find(params[:id])
		@band.destroy
		flash[:notice] = "#{@band.name} destroyed"
		redirect_to bands_url
	end

	private

	def band_params
		params.require(:band).permit(:name)
	end
end