class Track < ActiveRecord::Base
	validates :album_id, presence: true
	validates :track_type,  inclusion: { in: %w(regular bonus),
    message: "%{track_type} is not a valid track type" }
	belongs_to :album
	has_many :notes
	#belongs_to :band, through: :album, source: :band
end