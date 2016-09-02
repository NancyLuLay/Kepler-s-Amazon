class ReviewsController < ApplicationController

before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def create
    @review = Review.new params.require(:review).permit(:body, :star)
    @review.user = current_user
    @product = Product.find params[:product_id]
    @review.product = @product

    respond_to do |format|
      if @review.save
      format.html {redirect_to product_path(@product), notice: "Review created"}
      format.js {render :create_success }
      else
      flash[:alert] = "Please fix errors below"
      format.hmtl {render "/products/show"}
      format.js {render :create_failure}
      end
    end

  end

  def destroy
    p = Product.find params[:product_id]
    # r = Review.find params[:id]
    # r.destroy
    @review = Review.find params[:id]
    @review.destroy
      respond_to do |format|
      format.html {redirect_to product_path(p), notice: "Review deleted"}
      format.js {render}
      end
  end

end
