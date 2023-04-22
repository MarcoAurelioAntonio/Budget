class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates :prep_time, presence: true
  validates :cook_time, presence: true
  validates :description, presence: true
  validates :user, presence: true
end
