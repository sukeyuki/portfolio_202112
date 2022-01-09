FactoryBot.define do
  factory :schedule do
    title {"plan_name"}
    contents {
      "first:go to shcool
      second:play soccer
      third:go home"
    }
    start_at {'2001-02-03T12:13:14Z'}
    end_at {'2001-02-03T12:13:14Z'}
    association :group
  end

  trait :other_valid_schedule do
    title {"plan_name2"}
    contents {
      "first:go to company
      second:work
      third:go home"
    }
    start_at {'2001-03-03T12:13:14Z'}
    end_at {'2001-03-03T12:13:14Z'}
    association :group
  end


  trait :schedule_with_blank_attributes do
    title {nil}
    group_id {nil}
    contents {nil}
    start_at {nil}
    end_at {nil}
  end

  trait :schedule_with_long_attributes do
    title {"a"*51}
    contents {"a"*1001}
  end

end
