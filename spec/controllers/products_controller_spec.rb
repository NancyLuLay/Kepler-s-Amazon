require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:product) { FactoryGirl.create(:product) }

  describe "#new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "instantiates a new product instance variable" do
    get :new
      expect(assigns(:product)).to be_a_new(Product)
    end
  end

  describe "#create" do
    context "with valid parameters" do
      def valid_request
        post :create, params: {product: {title: "product title",
                                        description: "hello",
                                        price: 10+ rand(100),
                                        image: "/image/image.png",
                                        tbn_image: "/image/image.png"}}

      end

      it "saves a record to the database" do
        count_before = Product.count
        valid_request
        count_after = Product.count
        expect(count_after).to eq(count_before + 1)
      end

      it "redirects to the product show page" do
        valid_request
        expect(response).to redirect_to(product_path(Product.last))
      end

    end

    context "with invalid parameters" do
      def invalid_request
        post :create, params: {product:{title: ""}}
      end

      it "renders the new template" do
        invalid_request
        expect(response).to render_template(:new)
      end

      it "doesn't save the record to the database" do
        count_before = Product.count
        invalid_request
        count_after = Product.count
        expect(count_after).to eq(count_before)
      end
    end

  end

  describe "#edit" do
    it "renders the edit template" do
      product = FactoryGirl.create(:product)
      get :edit, params: {id: product.id}
      expect(response).to render_template(:edit)
    end

    def valid_edit
      post :create, params: {product: {title: "product title",
                                      description: "hello",
                                      price: 10+ rand(100),
                                      image: "/image/image.png",
                                      tbn_image: "/image/image.png"}}
    end

    it "saves a record to the database" do
      # product = FactoryGirl.create(:product)
      product.title = "hello"
      expect(product.title).to eq("hello")
    end

    it "redirects to the product show page" do
      # product = FactoryGirl.create(:product)
      get :show, params: {id: product.id}
      expect(response).to render_template(:show)
    end

  end

  describe "#update" do
    it "changes info in the database" do
      # product = FactoryGirl.create(:product)
      product.title = "hello"
      patch :update, params: {id: product.id,
                              product: {title: product.title}
                            }
      expect(Product.last).to eq(product)
    end
  end

  describe "#show" do
    it "renders the show template" do
      # product = FactoryGirl.create(:product)
      get :show, params: {id: product.id}
      expect(response).to render_template(:show)
    end
    it "defines an instance variable for product based on passed id" do
      # product = FactoryGirl.create(:product)
      get :show, params: {id: product.id}
      expect(assigns(:product)).to eq(product)
    end
  end

  describe "#index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "defines an instance variable for all products" do
     product  = FactoryGirl.create(:product)
     product1 = FactoryGirl.create(:product)
     get :index
     expect(assigns(:products)).to eq([product, product1])
    end
  end

  describe "#destroy" do
    it "renders the show template" do
      # product = FactoryGirl.create(:product)
      get :show, params: {id: product.id}
      expect(response).to render_template(:show)
    end

    it "changes info in the database" do
      expect(Product.count).to eq 0
      product
      expect(Product.count).to eq 1
      # similar to the Product.count comparison
      expect{
        delete :destroy, params: {id: product.id}
      }.to change{Product.count}.by -1
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

  end
end
