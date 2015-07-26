class ContactShare < ActiveRecord::Base
  validates :user_id, :contact_id, presence: true
  validates :user_id, :uniqueness => { :scope => :contact_id }

  belongs_to(
    :user,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: 'User'
            )

  belongs_to(
    :contact,
    foreign_key: :contact_id,
    primary_key: :id,
    class_name: 'Contact'
            )


end
