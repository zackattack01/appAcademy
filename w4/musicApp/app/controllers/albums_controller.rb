class AlbumsController < ApplicationController
	before_action :require_logged_in_user

	def new
		@album = Album.new
		render :new
	end

	def create
		@album = Album.create(album_params)
		if @album.save
			flash[:notice] = "Album created!"
			redirect_to album_url(@album)
		else
			flash[:errors] = ["Unable to save album :("]
			redirect_to new_band_album_url(@album.band_id)
		end
	end

	def edit
		@album = Album.find(params[:id])
		render :edit
	end

	def update
		@album = Album.find(params[:id])
		if @album.update(album_params)
			flash[:notice] = "Album Updated!"
			redirect_to album_url(@album)
		else
			flash[:errors] = @album.full_error_messages
			render :edit
		end
	end

	def destroy
		@album = Album.find(params[:id])
		@album.destroy
		flash[:notice] = "#{@album.title} destroyed"
		redirect_to bands_url
	end

	def show
		@album = Album.find(params[:id])
		render :show
	end

	private

	def album_params
		params.require(:album).permit(:band_id, :rec_type, :title)
	end
end