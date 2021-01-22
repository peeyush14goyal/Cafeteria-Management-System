class MenuItem < ApplicationRecord
  def self.activeMenuItems(id)
    all.where(menu_id: id)
  end
end
