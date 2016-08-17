class Review < ApplicationRecord
  belongs_to :product
  validates :body, uniqueness: {scope: :product_id}
  validates :star, presence: true, :inclusion => 1..5
end
