class Note < ActiveRecord::Base
	validates :words, :user_id, :track_id, presence: true
	belongs_to :track
	belongs_to :user
end
