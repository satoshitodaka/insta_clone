admin_user = User.create(
  email: 'admin@example.com',
    username: 'satoshi todaka',
    password: 'password',
    password_confirmation: 'password'
)
puts "\"#{admin_user.username}\" has created!"

puts 'Starting insert seed "users"...'
10.times do
  user = User.create(
    email: Faker::Internet.unique.email,
    username: Faker::Internet.unique.user_name,
    password: 'password',
    password_confirmation: 'password'
  )
  puts "\"#{user.username}\" has created!"
end