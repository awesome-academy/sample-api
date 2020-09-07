class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.user.email.regex

  validates :name, presence: true, length: {maximum: Settings.user.name.maximum}

  validates :email, presence: true,
             length: {maximum: Settings.user.email.maximum},
             format: {with: VALID_EMAIL_REGEX}, uniqueness: true

  validates :password, presence: true,
             length: {minimum: Settings.user.password.minimum}

  before_save :email_downcase

  has_secure_password

  private

  def email_downcase
    email.downcase!
  end
end
