FactoryBot.define do
  factory :post do
    body { Faker::Hacker.say_something_smart }
    images { [File.open("#{Rails.root}/spec/factories/fixture.png")] }
    user
  end
end
