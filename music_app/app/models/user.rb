class User < ApplicationRecord
  validates :email, :password_digest, :session_token, presence: true
  validate :password, length {minimum: 6, allow_nil: true}

  attr_reader: :password
  after_initialize: ensure_session_token

  def is_password?

  end

  


end
