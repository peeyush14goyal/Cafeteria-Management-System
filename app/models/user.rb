class User < ApplicationRecord
  has_many :orders
  validates :first_name, presence: true
  validates :email, presence: true
  validates :password, length: { minimum: 3 }
  has_secure_password
end
