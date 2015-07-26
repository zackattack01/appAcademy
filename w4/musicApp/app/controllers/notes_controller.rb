class NotesController < ApplicationController
	before_action :check_note_ownership, only: [:destroy]

	def new
		@note = Note.new
		render :new
	end

	def create
		@note = Note.create(note_params)
		@note.user_id = current_user.id
		@note.track_id = params[:track_id]
		if @note.save
			flash[:notice] = "Note posted!"
		else
			flash[:errors] = @note.full_error_messages
		end

		redirect_to track_url(@note.track)
	end

	def destroy
		@note = Note.find(params[:id])
		@note.destroy
		redirect_to track_url(@note.track)
	end

	def check_note_ownership
		@note = Note.find(params[:id])
		unless current_user = @note.user 
			render text: "BAD BAD 403 FORBIDDEN"
		end
	end

	private

	def note_params
		params.require(:note).permit(:words)
	end
end