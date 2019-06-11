class User < ApplicationRecord
  has_many :questions
  has_many :answers

  before_save :encrypt_password

  validates :email, presence: true, length: { maximum: 100 }, uniqueness: true
  validates :firstname, presence: true, length: { maximum: 50 }
  validates :lastname, presence: true, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 6, maximum: 50 }, confirmation: true

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    if(!user.nil?)
      password = BCrypt::Engine.hash_secret(password, user.password_salt)
      if(password == user.password)
        return true
      end
      return false
    end
    return false
  end
end
