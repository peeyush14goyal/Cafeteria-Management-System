class Menu < ApplicationRecord
  has_many :menu_items

  def self.isActive
    all.find_by(active: true)
  end
  def self.getActiveMenu
    all.find_by(active: true)
  end

  def self.getMenu(id)
    all.find_by(id: id)
  end
end
