class MenuItem < ApplicationRecord
  belongs_to :menu
  def self.activeMenuItems(id)
    all.where(menu_id: id)
  end

  def self.getItem(id)
    all.find_by(id: id)
  end
end
