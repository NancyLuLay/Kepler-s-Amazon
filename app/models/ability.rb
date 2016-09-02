class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, Review do |review|

      user == review.user
    end

    can :like, Review do |review|
      user != review.user
    end

    # cannot :like, Review do |review|
    #   user == review.user
    # end

    can :destroy, Like do |like|
      user == like.user
    end

    can :favourite, Product do |product|
      user != product.user
    end

    # cannot :favourite, Product do |product|
    #   # binding.pry
    #   user == product.user
    # end

    can :destroy, Favourite do |favourite|
      user == favourite.user
    end

  end

end
