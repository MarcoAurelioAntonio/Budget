class Food < ApplicationRecord
	# has_many :inventory_foods, dependent: :destroy
	# has_many :recipe_foods, dependent: :destroy

	validates :name, presence: true
	validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
	validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
