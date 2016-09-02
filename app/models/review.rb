class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product

  has_many :likes, dependent: :destroy
  has_many :users, through: :likes

  validates :body, presence: true, uniqueness: {scope: :product_id}
  validates :star, presence: true, :inclusion => 1..5

  def like_for(user)
    likes.find_by_user_id user
  end

end
