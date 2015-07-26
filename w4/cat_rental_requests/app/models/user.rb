class User < ActiveRecord::Base
  validates :username, :session_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  after_initialize :ensure_session_token
  attr_reader :password

  has_many(
    :cats,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: 'Cat'
  )

  has_many :cat_rental_requests

  def ensure_session_token #This should be saved after initialization, during "create"ion
    self.session_token ||= User.generate_session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(user_params)
    user = User.find_by(username: user_params["username"])
    if user && user.is_password?(user_params["password"])
      user
    else
      nil
    end
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end
end
