require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let(:category) { FactoryGirl.create(:category) }
  let(:user) { FactoryGirl.create(:user) }
  let(:product) { FactoryGirl.create(:product, user: user, category: category ) }
  let(:review) { FactoryGirl.create(:review, user: user, product: product)}

  describe "#create" do
      context "with no signed in user" do
        it "redirects to root path" do
          post :create, params: { body: 10,
                                  star: 5,
                                  product_id: 1,
                                  user_id: 1,
                                  review_id: review.id}
          expect(response).to redirect_to root_path
        end
      end

      context "with signed in user" do
        before { request.session[:user_id] = user.id }

        context "with valid attributes" do
          def valid_request
            post :create, params: { body: 10,
                                  star: 5,
                                  product_id: 1,
                                  user_id: 1,
                                  review_id: review.id}
          end

          it "creates a review in the database" do
            count_before = Review.count
            valid_request
            count_after = Review.count
            expect(count_after).to eq(count_before + 1)
          end

          it "redirects to the review show page" do
            valid_request
            expect(response).to redirect_to(review_path(review))
          end

        end

      end
  end
end
