class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  after_create :assign_admin_role_to_first_user

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  has_many :recipes, foreign_key: 'user_id', dependent: :destroy
  validates :name, presence: true, length: { maximum: 250 }

  has_many :inventory

  def admin?
    role == 'admin'
  end

  def user?
    role == 'user'
  end

  def self.new_gest
    guest = find_by(guest: true)
    guest.nil? ? create(name: 'Guest', guest: true) : guest
  end

  private

  def assign_admin_role_to_first_user
    return unless User.count == 1

    update(role: 'admin')
  end
end
