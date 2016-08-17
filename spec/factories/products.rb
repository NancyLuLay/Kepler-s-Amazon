FactoryGirl.define do
  factory :product do
    sequence(:title)  {|n| Faker::Company.bs + n.to_s  }
    description       {    Faker::ChuckNorris.fact     }
    price             {    10 + rand(100)           }
    image             {    Faker::Avatar.image       }
    tbn_image         {    Faker::Avatar.image       }
  end
end
