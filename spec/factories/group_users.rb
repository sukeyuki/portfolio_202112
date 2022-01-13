FactoryBot.define do
  factory :group_user do
    association :user
    association :group
    role {30}
  end

  trait :group_user_with_blank_attributesa do
    user_id {nil}
    group_id {nil}
    activated {nil}
  end
end
