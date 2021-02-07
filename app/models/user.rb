class User < ApplicationRecord
  has_many :orders
  validates :first_name, presence: true
  validates :email, presence: true
  validates :password, length: { minimum: 3 }
  has_secure_password

  def self.get_customers
    all.where(role: "Customer")
  end

  def self.get_clerks
    all.where(role: "clerk")
  end

  def self.get_customer_type(current_user_role)
    if (current_user_role == "admin" || current_user_role == "clerk")
      "Walk-in"
    else
      "Online"
    end
  end
end
