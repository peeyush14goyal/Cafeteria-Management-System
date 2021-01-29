class Menu < ApplicationRecord
  validates :name, presence: true
  has_many :menu_items

  def self.isActive
    all.find_by(active: true)
  end
  def self.getActiveMenu
    all.find_by(active: true)
  end

  def self.getMenu(id)
    find_by(id: id)
  end
end
