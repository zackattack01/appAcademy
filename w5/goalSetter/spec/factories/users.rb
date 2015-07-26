FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name }
    password "password"

    factory :user2 do
      username { Faker::Internet.user_name }
    end
  end

end
