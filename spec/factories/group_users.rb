FactoryBot.define do
  factory :group_user, class: GroupUser do
    association :user
    association :group
  end

  trait :invite_user do
    activated {false}
    role {"normal"}
  end

  trait :as_normal_user do
    activated {true}
    role {"normal"}
  end
 
  trait :as_admin_user do
    activated {true}
    role {"admin"}
  end

  trait :group_user_with_blank_attributes do
    user {nil}
    group {nil}
    activated {nil}
    role {nil}
  end
end
