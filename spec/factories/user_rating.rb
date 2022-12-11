FactoryBot.define do
  factory :user_rating do
    recipe

    user

    # jitera-anchor-dont-touch: columns
    star { Faker::Number.between(from: 1, to: 5) }
  end
end
