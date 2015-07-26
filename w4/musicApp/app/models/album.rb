class Album < ActiveRecord::Base
	validates :band_id, presence: true
	validates :rec_type,  inclusion: { in: %w(live studio),
    message: "%{rec_type} is not a valid recording type" }
	belongs_to :band
	has_many :tracks, dependent: :destroy
end
