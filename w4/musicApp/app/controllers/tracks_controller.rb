class TracksController < ApplicationController
	before_action :require_logged_in_user
	def new
		@track = Track.new
		render :new
	end

	def create
		@track = Track.create(track_params)
		if @track.save
			flash[:notice] = "track created!"
			redirect_to track_url(@track)
		else
			flash[:errors] = ["Unable to save track :("]
			redirect_to new_band_track_url(@track.band_id)
		end
	end

	def edit
		@track = Track.find(params[:id])
		render :edit
	end

	def update
		@track = Track.find(params[:id])
		if @track.update(track_params)
			flash[:notice] = "track Updated!"
			redirect_to track_url(@track)
		else
			flash[:errors] = @track.full_error_messages
			render :edit
		end
	end

	def destroy
		@track = Track.find(params[:id])
		@track.destroy
		flash[:notice] = "#{@track.title} destroyed"
		redirect_to album_url(@track.album)
	end

	def show
		@track = Track.find(params[:id])
		render :show
	end

	private

	def track_params
		params.require(:track).permit(:album_id, :track_type, :title)
	end
end