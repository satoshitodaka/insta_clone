User.create(
  name: 'sample_user',
  email: 'sample@example.com'
)

10.times do |n|
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password'
  )
end

# Post.create(
#   title: 'お気に入りの猫',
#   comment: '癒されます',
#   images: '[\"cat-g97e5cd23f_1280.png\",\"eyes-gec15974d8_640.png\"]',
#   images: 'sample.png',
#   user_id: 1
# )
