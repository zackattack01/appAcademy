class Visit < ActiveRecord::Base
  validates :user_id, presence: true
  validates :shortened_url_id, presence: true

  belongs_to(
    :shortened_url,
    foreign_key: :shortened_url_id,
    primary_key: :id,
    class_name: 'ShortenedUrl'
  )

  belongs_to(
    :visitor,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: 'User'
  )

  def self.record_visit!(user, shortened_url)
    Visit.create!(user_id: user.id, shortened_url_id: shortened_url.id)
  end
end
