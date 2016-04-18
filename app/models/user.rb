class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, confirmation: true, presence: true
  has_many :links
  has_many :comments
  has_secure_password
  
end
