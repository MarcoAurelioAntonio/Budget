class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates :prep_time, presence: true
  validates :cook_time, presence: true
  validates :description, presence: true
  validates :user, presence: true

  def total_food_items
    recipe_foods.count
  end

  def total_price
    total = 0
    recipe_foods.each do |recipe_food|
      total += recipe_food.quantity * recipe_food.food.price
    end
    total
  end
end
