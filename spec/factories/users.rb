FactoryBot.define do
  factory :user, class: User do
    name {"tarou"}
    sequence(:search_name){|n| "tarou#{n}"}
    sequence(:email) {|n|"tarou#{n}@tarou.com"}
    password {"123456"}
    password_confirmation {"123456"}

    trait :user_with_blank_name_and_userid_email do
      name {nil}
      search_name {nil}
      email {nil}
    end

    trait :user_with_short_password do
      password {"12345"}
      password_confirmation {"12345"}
    end
  end

  factory :other_user,class: User do
    name {"jirou"}
    search_name {"jirou"}
    email {"jirou@jirou.com"}
    password {"123456"}
    password_confirmation {"123456"}
  end
end
