class ReviewsController < ApplicationController
  def create
    @review = Review.new params.require(:review).permit(:body, :star)
    @product = Product.find params[:product_id]
    @review.product = @product
    if @review.save
    redirect_to product_path(@product), notice: "Review created"
    else
    flash[:alert] = "Please fix errors below"
    render "/products/show"
    end
  end

  def destroy
    p = Product.find params[:product_id]
    r = Review.find params[:id]
    r.destroy
    redirect_to product_path(p), notice: "Review deleted"
  end

end
