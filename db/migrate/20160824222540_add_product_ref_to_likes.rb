class AddProductRefToLikes < ActiveRecord::Migration[5.0]
  def change
    add_reference :likes, :product, foreign_key: true
  end
end
