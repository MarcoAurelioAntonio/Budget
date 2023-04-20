class Inventory < ApplicationRecord
  belongs_to :user

  has_many :inventory_foods

  validates :name, presence: true, length: { maximum: 255 }
  validates :user, presence: true
end
