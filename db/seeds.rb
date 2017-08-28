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

User.create!(email: 'test@gmail.com', password: '12345678', confirm_at: Time.now, first_name: 'a', last_name: 'b');
# User.create!(email: 'a@b.c', password: '12345678', token: 'abc');
