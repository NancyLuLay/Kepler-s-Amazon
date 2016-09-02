FactoryGirl.define do
  factory :review do
    body       {"MyText"}
    product
    user
    star       {[1,2,3,4,5].sample}
  end
end
