class Expense < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :group_expenses, dependent: :destroy
  has_many :groups, through: :group_expenses, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 },
                   uniqueness: { scope: :author, message: 'You already have an expense with this name' }
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
