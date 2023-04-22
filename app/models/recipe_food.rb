class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :food, presence: true
  validates :recipe, presence: true

  def value
    food.price * quantity
  end
end
