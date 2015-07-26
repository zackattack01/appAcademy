# == Schema Information
#
# Table name: shortened_urls
#
#  id           :integer          not null, primary key
#  long_url     :string
#  short_url    :string
#  submitter_id :integer
#

require 'securerandom'

class ShortenedUrl < ActiveRecord::Base
  validates :short_url, presence: :true, uniqueness: :true
  validates :long_url, length: { maximum: 255 }
  validate :spam_check
  validate :not_too_many_urls

  belongs_to(
    :user,
    foreign_key: :submitter_id,
    primary_key: :id,
    class_name: "User"
  )

  has_many(
    :visits,
    foreign_key: :shortened_url_id,
    primary_key: :id,
    class_name: 'Visit'
  )

  has_many(
    :visitors,
    -> { distinct },
    through: :visits,
    source: :visitor
  )

  has_many(
    :taggings,
    foreign_key: :shortened_url_id,
    primary_key: :id,
    class_name: "Tagging"
  )

  has_many(
    :tag_topics,
    through: :taggings,
    source: :tag_topic
  )

  def self.prune
    old_urls = []
    self.find_each do |url|
      if url.visits.where('created_at > ?', 60.minutes.ago).count < 1
        old_urls << url
      end
    end

    old_urls.each { |url| url.delete }
  end

  def self.random_code
    new_short_url = SecureRandom.base64(16)
    while ShortenedUrl.exists?(short_url: new_short_url)
      new_short_url = SecureRandom.base64(16)
    end

    new_short_url
  end

  def self.create_for_user_and_long_url!(user, long_url)
    self.create!(
      long_url: long_url,
      short_url: random_code,
      submitter_id: user.id
    )
  end

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_unique
    self.visits.where("created_at > ?", 120.minutes.ago)
                      .select(:user_id).distinct.count
  end

  private

  def spam_check
    if ShortenedUrl.where("created_at > ? AND submitter_id = ?",
                          1.minute.ago, submitter_id).count >= 5
      errors[:base] << "Spam detected"
    end
  end

  def not_too_many_urls
    unless User.find(submitter_id).premium
      if ShortenedUrl.where("submitter_id = ?", submitter_id).count >= 5
        errors[:base] << "Passed non-premium URL limit"
      end
    end
  end
end
