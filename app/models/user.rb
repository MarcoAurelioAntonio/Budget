class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  validates :name, presence: true, length: { maximum: 250 }

  has_many :inventory

  def admin?
    role == 'admin'
  end

  def user?
    role == 'user'
  end
end
