require 'rails_helper'

RSpec.describe GroupUser, type: :model do
  context "with valid data" do
    before do
      @group_user = FactoryBot.build(:group_user)
      @group_user.valid?
    end

    it "is valid" do
      expect(@group_user).to be_valid
    end

    it "can create associated data of user" do
      expect(@group_user.user).to be_valid
    end

    it "can create associated data of group" do
      expect(@group_user.group).to be_valid
    end
  end

  context "with blank attributes" do
    before do
      @group_user = FactoryBot.build(:group_user, :group_user_with_blank_attributes)
      @group_user.valid?
    end

    it "has :user error" do
      expect(@group_user.errors[:user]).to include("を入力してください")
    end

    it "has :group error" do
      expect(@group_user.errors[:group]).to include("を入力してください")
    end

    it "has :activated error" do
      expect(@group_user.errors[:activated]).to include("は一覧にありません")
    end
  end
end
