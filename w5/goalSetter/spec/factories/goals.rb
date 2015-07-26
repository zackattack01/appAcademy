FactoryGirl.define do
  factory :goal do
    body "this is a public goal"
    visible "Public"

    factory :private_goal do
      body "this is a private goal"
      visible "Private"
    end
  end
end
