# frozen_string_literal: true

class User < ApplicationRecord
  has_many :questions
  has_many :answers
  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' },
                             default_url: '/images/:style/missing.png'

  before_save :encrypt_password, :generate_api_key

  validates :email, presence: true, length: { maximum: 100 }, uniqueness: true
  validates :firstname, presence: true, length: { maximum: 50 }
  validates :lastname, presence: true, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }, confirmation: true
  validates_attachment_content_type :avatar, content_type: %r{\Aimage\/.*\z}

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def generate_api_key
    self.api_key = BCrypt::Engine.generate_salt
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    unless user.nil?
      password = BCrypt::Engine.hash_secret(password, user.password_salt)
      return user if password == user.password

      return nil
    end
    nil
  end

  def self.already_exists?(email)
    true if User.find_by_email(email)
  end

  def name
    firstname + ' ' + lastname
  end
end
