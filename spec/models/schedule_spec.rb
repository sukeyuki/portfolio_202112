require 'rails_helper'

RSpec.describe Schedule, type: :model do

  it "is valid with correct data" do
    expect(FactoryBot.build(:schedule)).to be_valid
  end

  it "is invalid with blank attributes" do
    schedule = FactoryBot.build(:schedule, :schedule_with_blank_attributes)
    schedule.valid?
    # FIXME: 下記テストが通らない。なぜかスルーしてしまう。rails c にて行った際は下記エラーが発出しているのに。。。
    expect(schedule.errors[:title]).to include("can't be blank")
    expect(schedule.errors[:group]).to include("must exist")
    expect(schedule.errors[:contents]).to include("can't be blank")
    expect(schedule.errors[:start_at]).to include("can't be blank")
    expect(schedule.errors[:end_at]).to include("can't be blank")
  end

  it "is invalid with long attributes" do
    schedule = FactoryBot.build(:schedule, :schedule_with_long_attributes)
    schedule.valid?
    expect(schedule.errors[:title]).to include("is too long (maximum is 50 characters)")
    expect(schedule.errors[:contents]).to include("is too long (maximum is 1000 characters)")
  end
end