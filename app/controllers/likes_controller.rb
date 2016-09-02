class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    review = Review.find params[:review_id]
    like = Like.new user: current_user, review: review
    if !(can? :like, review)
      redirect_to root_path, alert: "access denied"
    elsif like.save
      redirect_to product_path(review.product), notice: "Thanks for liking"
    else
      redirect_to product_path(review.product), alert: like.errors.full_messages.join(", ")
    end
  end

    def destroy
    review = Review.find params[:review_id]
    product = Product.find params[:product_id]
    like = Like.find params[:id]
      if can? :destroy, like
        like.destroy
      redirect_to product_path(review.product), notice: "Like removed!"
      else
      redirect_to root_path, alert: "access denied!"
      end
    end
end
