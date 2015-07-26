class Goal < ActiveRecord::Base
  belongs_to :user

  VISIBLE =["Public", "Private"]

  validates :body, :user, presence: true
  validates :visible, inclusion: VISIBLE
end
