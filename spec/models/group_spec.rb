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
      expect(@group_with_blank_attr.errors[:name]).to include("を入力してください")
    end

    it "has :personal error" do
      @group_with_blank_attr.valid?
      expect(@group_with_blank_attr.errors[:personal]).to include("は一覧にありません")
    end
  end

  context "with long attributes" do
    before do
      @group_with_long_attr = FactoryBot.build(:group, :group_with_long_attributes)
    end

    it "has :name error" do
      @group_with_long_attr.valid?
      expect(@group_with_long_attr.errors[:name]).to include("は50文字以内で入力してください")
    end

    it "has :overview error" do
      @group_with_long_attr.valid?
      expect(@group_with_long_attr.errors[:overview]).to include("は1000文字以内で入力してください")
    end
  end
end
