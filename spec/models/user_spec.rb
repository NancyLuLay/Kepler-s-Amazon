require 'rails_helper'

RSpec.describe User, type: :model do

  it "requires a first name" do
    attributes = FactoryGirl.attributes_for :user
    attributes[:first_name] = nil
    user = User.new attributes
    # shortcut
    # user = User.new FactoryGirl.attributes_for(:user).merge({first_name: nil})
    user.valid?
    expect(user.errors).to have_key(:first_name)
  end

  it "requires a last name" do
    attributes = FactoryGirl.attributes_for :user
    attributes[:last_name] = nil
    user = User.new attributes
    user.valid?
    expect(user.errors).to have_key(:last_name)
  end

  it "requires a unique email" do
    user = FactoryGirl.create(:user)
    attributes = FactoryGirl.attributes_for :user
    attributes[:email] = user.email
    user1 = User.new attributes
    user1.valid?
    expect(user1.errors).to have_key(:email)
  end

  it "requires a titleized first_name concatenated with last_name" do
    u = User.new first_name: "nancy", last_name: "lu"
    outcome = u.full_name
    expect(outcome).to eq("Nancy Lu")
  end

end
