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

if Unit.exists?
  puts 'Unit already exist'
else
  Unit.create!(name: 'Peace')
  Unit.create!(name: 'Set')
  puts 'Unit created done'
end

if Shop.exists?
  puts 'Shop already exist'
else
  Shop.create!(id: 1, shop_name: 'Shop Vi', logo: 'logo', phone: '012345678', address: 'asian tech', status: 'ok')
  Shop.create!(id: 2, shop_name: 'Shop Vinh', logo: 'logo', phone: '012345678', address: 'asian tech', status: 'ok')
  Shop.create!(id: 3, shop_name: 'Shop Chi', logo: 'logo', phone: '012345678', address: 'asian tech', status: 'ok')
  puts 'Shop created done'
end

if Category.exists?
  puts 'Category already exist'
else
  category = {}
  category['Electronics'] = [
    'Mobiles & Tablets',
    'Computers & Laptops',
    'Cameras',
    'Tivis'
  ]
  category['Fashion'] = [
    'Shop all watches',
    'Shop all bages',
    'Shop all shoes',
    'Shop all jewellery',
    'Shop all eyewear'
  ]
  category['Home & Living'] = [
    'Kitchen Appliances',
    'Kitchenware',
    'Furniture',
    'Home decor',
    'Laundry & Cleaning',
    'Storage & Organization'
  ]

  print 'Category :         '
  category.each do |i|
    Category.create!(name: i.first)
    now = Category.select('id').find_by(name: i.first).id
    i.last.each do |j|
      Category.create!(name: j, parent_id: now)
      print '.'
    end
  end
  puts 'Done'
end

if Product.all.size > 101
  puts 'Product already exist'
else
  print "Product :          "
  unit_count = Unit.count
  shop_count = Shop.count
  category_count = Category.count
  50.times do |i|
    Product.create!(
      name: Faker::Book.title,
      price: Faker::Number.number(5),
      unit_id: 1+rand(unit_count),
      shop_id: 1+rand(shop_count),
      category_id: 1+rand(category_count),
      quantity_stock: Faker::Number.number(3),
      description: Faker::Book.author,
      detail: '1234 nay'
      )
    print '.' if( i % 5 == 0 )
  end
  puts 'Done'
  print "Product image:     "
  Product.all.each_with_index do |i, j|
    ProductImage.create!(
        url: Faker::Avatar.image(i.slug,"200x200"),
        product_id: i.id
      )
    print '.' if( j % 5 == 0 )
  end
  2.times do |i|
    ProductImage.create!(
        url: Faker::Avatar.image(i,"200x200"),
        product_id: 1
      )
  end
  puts 'Done'
end



# User.create!(email: 'test@gmail.com', password: '12345678', confirm_at: Time.now, first_name: 'a', last_name: 'b');
# User.create!(email: 'a@b.c', password: '12345678', token: 'abc');
