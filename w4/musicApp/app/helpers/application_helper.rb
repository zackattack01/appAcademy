module ApplicationHelper

	def auth_token
		token = <<-HTML
			<input type='hidden' 
						 name='authenticity_token'
						 value=#{h(form_authenticity_token)}>
		HTML

		token.html_safe
	end

	def logout_button
		"#{button_to "log out", session_url, method: :delete}".html_safe
	end

	def index_bands
		"#{ button_to '<< Back to all bands', bands_url, method: :get}".html_safe
	end

	def back_to_band(band)
		back_to = "<< back to #{band.name}"
		"#{ button_to back_to, band_url(band), method: :get }".html_safe		
	end

	def back_to_album(album)
		back_to = "<< back to #{album.title}"
		"#{ button_to back_to, album_url(album), method: :get }".html_safe		
	end

	def go_to_album(album)
		"#{ link_to album.title, album_url(album) }".html_safe
	end

	def go_to_track(track)
		"#{ link_to track.title, track_url(track) }".html_safe
	end

	def make_new_album
		"#{ button_to 'Add an album!', new_band_album_url(params[:id]), method: :get }".html_safe
	end

	def bands
		Band.all.to_a
	end

	def delete_band(band)
		label = "Delete #{band.name}"
		"#{ button_to label, band_url(band), method: :delete}".html_safe
	end

	def delete_album(album)
		label = "Delete #{album.title}"
		"#{ button_to label, album_url(album), method: :delete}".html_safe
	end

	def edit_album(album)
		label = "Edit #{album.title}"
		"#{ button_to label, edit_album_url(album), method: :get }".html_safe
	end

	def delete_track(track)
		label = "Delete #{track.title}"
		"#{ button_to label, track_url(track), method: :delete}".html_safe
	end

	def edit_track(track)
		label = "Edit #{track.title}"
		"#{ button_to label, edit_track_url(track), method: :get }".html_safe
	end

	def edit_band(band)
		label = "Edit #{band.name}"
		"#{ button_to label, edit_band_url(band), method: :get }".html_safe
	end
end