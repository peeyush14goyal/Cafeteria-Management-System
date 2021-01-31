class User < ApplicationRecord
  has_many :orders
  validates :first_name, presence: true
  validates :email, presence: true
  validates :password, length: { minimum: 3 }
  has_secure_password

  def self.getCustomers
    all.where(role: "Customer")
  end

  def self.getClerks
    all.where(role: "clerk")
  end
end
