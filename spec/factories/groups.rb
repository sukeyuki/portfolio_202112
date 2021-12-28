FactoryBot.define do
  factory :group do
    name {"family"}
    overview{"my happy family"}
  end

  trait :group_with_blank_attributesa do
    name {nil}
    overview {nil}
  end

  trait :group_with_long_attributes do
    name {"a"*51}
    overview {"a"*1001}
  end
end
