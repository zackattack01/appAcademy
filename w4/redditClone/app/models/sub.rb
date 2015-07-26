# == Schema Information
#
# Table name: subs
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Sub < ActiveRecord::Base
  validates :moderator, presence: true
  validates :title, presence: true

  belongs_to(
    :moderator,
    foreign_key: :user_id,
    class_name: :User
  )
  has_many :post_subs
  has_many :posts, through: :post_subs
end
