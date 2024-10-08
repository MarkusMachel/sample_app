class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  before_save { email.downcase! }

  validates :name, presence: true, 
    length: { maximum: 50 }

  validates :email, presence: true, 
    length: { maximum: 255 }, 
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { uniqueness: true }

  validates :password, length: { minimum: 6 },
    presence: true
    
  has_secure_password

  # Returns the has digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
