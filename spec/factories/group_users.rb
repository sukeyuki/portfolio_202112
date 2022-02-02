FactoryBot.define do
  factory :group_user, class: GroupUser do
    association :user
    association :group
  end

  trait :activated_true do
    activated {true}
  end

  trait :group_user_with_blank_attributes do
    user {nil}
    group {nil}
    activated {nil}
  end
end
