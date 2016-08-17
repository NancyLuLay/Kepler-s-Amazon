PRODUCTS_TO_CREATE = 30

PRODUCTS_TO_CREATE.times do
  Product.create title: Faker::Commerce.product_name,
    description: Faker::Hipster.paragraph,
    image: Faker::Avatar.image,
    tbn_image: Faker::Avatar.image,
    price: rand(100)

end

puts Cowsay.say "Created #{PRODUCTS_TO_CREATE} products"
