class User < ApplicationRecord
  validates :email, :password_digest, :session_token, presence: true
  validate :password, length {minimum: 6, allow_nil: true}

  attr_reader: :password
  after_initialize: :ensure_session_token

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    user && user.is_password?(password) ? user : nil
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

end
#
# Write methods to deal with the session token: User::generate_session_token, User#reset_session_token! and User#ensure_session_token.
# Write a User#password=(password) method which actually sets the password_digest attribute using BCrypt, and a User#is_password?(password) method to check the users' password when they log in.
# Be careful setting instance variables in ActiveRecord, you can't just set @password_digest. In #password= use self.password_digest=. (self.___= calls a setter method defined for us by ActiveRecord, which is the state that is saved by self.save. While @___ makes a new instance variable, unrelated to self.save)
# Remember that in the User model, you'll want to use an after_initialize callback to set the session_token before validation if it's not present.
# Write a User::find_by_credentials(email, password) method.
