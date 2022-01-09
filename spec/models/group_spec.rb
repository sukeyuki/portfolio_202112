require 'rails_helper'

RSpec.describe Group, type: :model do
  it "is valid with correct data" do
    expect(FactoryBot.build(:group)).to be_valid
  end

  it "is invalid with blank attributes" do
    group = FactoryBot.build(:group, :group_with_blank_attributes)
    group.valid?
    expect(group.errors[:name]).to include("can't be blank")
    expect(group.errors[:overview]).to include("can't be blank")
    expect(group.errors[:personal]).to include("is not included in the list")
  end

  it "is invalid with long attributes" do
    group = FactoryBot.build(:group, :group_with_long_attributes)
    group.valid?
    expect(group.errors[:name]).to include("is too long (maximum is 50 characters)")
    expect(group.errors[:overview]).to include("is too long (maximum is 1000 characters)")
  end
end
