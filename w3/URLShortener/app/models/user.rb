# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true

  has_many(
    :shortened_urls,
    foreign_key: :submitter_id,
    primary_key: :id,
    class_name: "ShortenedUrl"
  )

  has_many(
    :visits,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: 'Visit'
  )

  has_many(
    :visited_urls,
    -> { distinct },
    through: :visits,
    source: :shortened_url
  )

end
