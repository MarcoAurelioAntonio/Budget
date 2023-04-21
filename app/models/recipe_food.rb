class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food

  def value
    food.price * quantity
  end
end
