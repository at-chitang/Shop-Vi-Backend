# User.create!(email: 'test@gmail.com', password: '12345678', active: Time.now);
# User.create!(email: 'a@b.c', password: '12345678', token: 'abc');
# 15.times do
#   ShopManager.create!(
#     username:   Faker::Twitter.screen_name,
#     password:   '12345678',
#     role:       Faker::Number.between(1, 2),
#     gender:     Faker::Number.between(0, 2),
#     avatar:     Faker::Avatar.image('my-own-slug', '100x100'),
#     phone:      Faker::PhoneNumber.phone_number,
#     manager_id: Faker::Number.between(1, 4)
#   )
# end

if Unit.all.size > 1
  puts 'Unit already exits'
else
  Unit.create!(name: 'Peace')
  Unit.create!(name: 'Set')
  puts 'Unit created done'
end

if Shop.all.size > 0
  puts 'Shop already exits'
else
  Shop.create!(id: 1, shop_name: 'Shop Vi', logo: 'logo', phone: '012345678', address: 'asian tech', status: 'ok')
  puts 'Shop created done'
end

if Product.all.size > 12
  puts 'Product already exits'
else
  print "Product :     "
  unit_count = Unit.count
  shop_all = Shop.all
  shop_count = Shop.count
  100.times do |i|
    Product.create!(
      name: Faker::Book.title,
      price: Faker::Number.number(5),
      unit_id: 1,
      shop_id: 1,
      quantity_stock: Faker::Number.number(3),
      description: Faker::Book.author,
      detail: '1234 nay'
      )
    print '.' if( i % 5 == 0 )
  end
  puts 'Done'
  print "Product image:     "
  Product.all.each do |i|
    ProductImage.create!(
        url: Faker::Avatar.image,
        product_id: i.id
      )
    print '.'
  end
  puts 'Done'
end

# User.create!(email: 'test@gmail.com', password: '12345678', confirm_at: Time.now, first_name: 'a', last_name: 'b');
# User.create!(email: 'a@b.c', password: '12345678', token: 'abc');
