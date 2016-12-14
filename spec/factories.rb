FactoryGirl.define do
  factory :user do
    email "extremely@legitimate.com"
  end

  factory :trained_user, class: User do
    email "cool@cool.com"

    after(:create) do |user|
        user.train "example data is really cool", "good"
        user.train "i hate animals", "bad"
    end
  end
end
