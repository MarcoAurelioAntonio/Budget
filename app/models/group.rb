class Group < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :group_expenses, dependent: :destroy
  has_many :expenses, through: :group_expenses, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 },
                   format: { with: /\A[\w\s.-]+\z/,
                             message: 'solo se permiten letras, números, espacios en blanco, guiones y puntos' }

  validates :name, uniqueness: { scope: :author, message: 'You already have a category with this name' }

  validates :icon, presence: true, length: { maximum: 500 },
                   format: { with: %r{\Ahttps://.+\z}, message: 'Debe ser una URL con el protocolo HTTPS' }

  def total_expenses
    expenses.sum(:amount)
  end
end
