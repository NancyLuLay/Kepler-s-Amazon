class Product < ApplicationRecord
  belongs_to :category
  has_many :reviews, dependent: :destroy

  has_many :favourites, dependent: :destroy
  has_many :users, through: :favourites

  belongs_to :user

  validates :title, presence: true, uniqueness: true
  validates :price, presence: true#, #numericality: { greater_than: 0, less_than: 1000 }
  validates :description, presence: true

  def favourite_for(user)
    favourites.find_by_user_id user
  end

end
