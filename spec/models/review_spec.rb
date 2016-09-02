require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "Validations for Star count" do
    it "requires a star count" do
      attributes = FactoryGirl.attributes_for :review
      attributes[:star] = nil
      review = Review.new attributes
      review.valid?
      expect(review.errors).to have_key(:star)
    end

    it "requires star to be between 1 and 5" do
      attributes = FactoryGirl.attributes_for :review
      review = Review.new attributes
      review.valid?
      expect(review[:star]).to be_between(1, 5).inclusive
    end

    it "does not accept a star value greater than 5" do
      attributes = FactoryGirl.attributes_for :review
      review = Review.new attributes
      review[:star] = 4
      review.valid?
      expect(review).to be_invalid
    end

  end
end
