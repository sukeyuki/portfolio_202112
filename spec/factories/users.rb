FactoryBot.define do
  factory :user do
    name {"tarou"}
    user_id {"tarou"}
    sequence(:email) {|n|"tarou#{n}@tarou.com"}
    # email {"tarou@tarou.com"}
    password {"123456"}
    password_confirmation {"123456"}

    trait :user_with_blank_name_and_userid_email do
      name {nil}
      user_id {nil}
      email {nil}
    end

    trait :user_with_short_password do
      password {"12345"}
      password_confirmation {"12345"}
    end
  end

  factory :other_user,class: User do
    name {"jirou"}
    user_id {"jirou"}
    email {"jirou@jirou.com"}
    password {"123456"}
    password_confirmation {"123456"}
  end
end
