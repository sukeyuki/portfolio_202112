require 'rails_helper'

RSpec.describe Group, type: :model do
  context "with valid data" do
    before do
      @group = FactoryBot.build(:group)
    end

    it "is valid" do
      expect(@group).to be_valid
    end
  end

  context "with blank attributes" do
    before do
      @group_with_blank_attr = FactoryBot.build(:group, :group_with_blank_attributes)
    end

    it "has :name error" do
      @group_with_blank_attr.valid?
      expect(@group_with_blank_attr.errors[:name]).to include("can't be blank")
    end

    it "has :overview error" do
      @group_with_blank_attr.valid?
      expect(@group_with_blank_attr.errors[:overview]).to include("can't be blank")
    end

    it "has :personal error" do
      @group_with_blank_attr.valid?
      expect(@group_with_blank_attr.errors[:personal]).to include("is not included in the list")
    end
  end

  context "with long attributes" do
    before do
      @group_with_long_attr = FactoryBot.build(:group, :group_with_long_attributes)
    end

    it "has :name error" do
      @group_with_long_attr.valid?
      expect(@group_with_long_attr.errors[:name]).to include("is too long (maximum is 50 characters)")
    end

    it "has :overview error" do
      @group_with_long_attr.valid?
      expect(@group_with_long_attr.errors[:overview]).to include("is too long (maximum is 1000 characters)")
    end
  end
end
