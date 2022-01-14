FactoryBot.define do
  factory :group , class: Group do
    name {"family"}
    overview{"my happy family"}
    personal {false}
  end

  trait :other_valid_group do
    name {"company"}
    overview{"good company"}
    personal {false}
  end


  trait :group_with_blank_attributes do
    name {nil}
    overview {nil}
    personal {nil}
  end

  trait :group_with_long_attributes do
    name {"a"*51}
    overview {"a"*1001}
  end
end
