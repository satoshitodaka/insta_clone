admin_user = User.create(
  email: 'admin@example',
    name: 'satoshi todaka',
    password: 'password',
    password_confirmation: 'password'
)
puts "\"#{admin_user.name}\" has created!"

puts 'Starting insert seed "users"...'
10.times do
  user = User.create(
    email: Faker::Internet.unique.email,
    name: Faker::Internet.unique.user_name,
    password: 'password',
    password_confirmation: 'password'
  )
  puts "\"#{user.name}\" has created!"
end