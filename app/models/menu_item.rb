class MenuItem < ApplicationRecord
  belongs_to :menu
  validates :name, presence: true
  validates :price, presence: true
  def self.activeMenuItems(id)
    all.where(menu_id: id)
  end

  def self.getItem(id)
    all.find_by(id: id)
  end

  def self.getAll
    all
  end

  def self.getMenuItems(id)
    all.where(menu_id: id)
  end

  def self.decodeBase64(encoded_base64_string)
    return decode(encoded_base64_string, "base64")
  end
end
