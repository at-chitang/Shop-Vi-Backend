print 'User              : '
if User.exists? || User.find_by(email: 'test@gmail.com')
  puts 'already exist'
 else
  User.create!(email: 'test@gmail.com', first_name: 'test', last_name: 'test', password: '12345678', confirm_at: Time.now);
  User.create!(email: 'a@a.a', first_name: 'a', last_name: 'a', password: '12345678', auth_token: 'a', confirm_at: Time.now);
  User.create!(email: 'a@b.c', first_name: 'a', last_name: 'b', password: '12345678', token: 'abc');
  puts 'created done'
end

print 'Unit              : '
if Unit.exists?
  puts 'already exist'
else
  Unit.create!(name: 'Peace')
  Unit.create!(name: 'Set')
  puts 'created done'
end

print 'Shop              : '
if Shop.exists?
  puts 'already exist'
else
  Shop.create!(id: 1, shop_name: 'Shop Vi', logo: 'logo', phone: '012345678', address: 'asian tech', status: 'ok')
  Shop.create!(id: 2, shop_name: 'Shop Vinh', logo: 'logo', phone: '012345678', address: 'asian tech', status: 'ok')
  Shop.create!(id: 3, shop_name: 'Shop Chi', logo: 'logo', phone: '012345678', address: 'asian tech', status: 'ok')
  puts 'created done'
end

print 'Category          : '
if Category.exists?
  puts 'already exist'
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

print "Product           : "
if Product.all.size > 101
  puts 'already exist'
else
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
  print "Product image     : "
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

print "Cart              : "
if Cart.exists?
  puts 'already exist'
else
  user_count = User.count
  product_count = Product.count
  category_count = Category.count
  (product_count*2).times do |i|
    cart = Cart.new(
      user_id: 1+rand(user_count),
      product_id: 1+rand(product_count),
      quantity: 1+rand(9),
    )
    print cart.save ? '.' : 'x'
  end
  puts 'Done'
end
