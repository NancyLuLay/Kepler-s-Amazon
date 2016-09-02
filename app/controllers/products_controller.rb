class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def new
    @product = Product.new
  end

  def index
    @products = Product.order(created_at: :desc).last(20)
  end

  def show
    @product = Product.find params[:id]
    @review = Review.new
    @category = @product.category
  end

  def edit
    @product = Product.find params[:id]
  end

  def update
    @product = Product.find params[:id]
    if @product.update params.require(:product).permit([:title, :description, :price, :image, :tbn_image, :category_id])
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def create
   product_params  = params.require(:product).permit([:title, :description, :price, :image, :tbn_image, :category_id])
    @product       = Product.new product_params

    @product.user = current_user

    if @product.save
      redirect_to product_path(@product)
    else
      render :new
    end
  end


# def create
#     @campaign = Campaign.new params.require(:campaign).permit(:title,
#                                                                   :description,
#                                                                   :goal,
#                                                                   :end_date)
#     if @campaign.save
#     redirect_to campaign_path(@campaign), notice: "Campaign created"
#   else
#     render :new
#   end

  def destroy
    product = Product.find params[:id]
    product.destroy!
    redirect_to products_path
  end

end
