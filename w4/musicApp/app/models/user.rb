class User < ActiveRecord::Base
	validates :email, :session_token, presence: true, uniqueness: true
	validates :password, length: { minimum: 6, allow_nil: true }
	after_initialize :ensure_session_token 
	has_many :notes
	attr_reader :password

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

	def is_password?(password)
		BCrypt::Password.new(password_digest).is_password?(password)
	end

	def reset_session_token!
		self.session_token = generate_session_token
		self.save!
	end

	def ensure_session_token
		self.session_token ||= generate_session_token
	end

	def generate_session_token
		SecureRandom.urlsafe_base64
	end

	def self.find_by_credentials(email, password)
		user = self.find_by(email: email)
		if user && user.is_password?(password)
			user
		else
			## or maybe raise error here
			nil
		end
	end
end
