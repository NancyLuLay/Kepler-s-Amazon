class FavouritesController < ApplicationController
 before_action :authenticate_user!

  def create
    product = Product.find params[:product_id]
    favourite = Favourite.new user: current_user, product: product
    if !(can? :favourite, product)
      redirect_to root_path, alert: "access denied"
    elsif favourite.save
      redirect_to product_path(product), notice: "Thanks for adding a favourite"
    else
      redirect_to product_path(product), alert: favourite.errors.full_messages.join(", ")
    end
  end

  def destroy
    product = Product.find params[:product_id]
    favourite = Favourite.find params[:id]
    if can? :destroy, favourite
      favourite.destroy
      redirect_to product_path(product), notice: "Favourite removed!"
    else
      redirect_to root_path, alert: "access denied!"
    end
  end

end
