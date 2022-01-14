require 'rails_helper'

RSpec.describe User, type: :model do
  context "with valid data" do
    it "is valid" do
      expect(FactoryBot.build(:user)).to be_valid
    end
  end

  context "with blank attributes" do
    before do
      @user = FactoryBot.build(:user, :user_with_blank_name_and_userid_email)
      @user.valid?
    end

    it "has :name errors" do
      expect(@user.errors[:name]).to include("can't be blank")
    end

    it "has :search_name errors" do
      expect(@user.errors[:search_name]).to include("can't be blank")
    end

    it "has :email errors" do
      expect(@user.errors[:email]).to include("can't be blank")
    end
  end

  context "with short attributes" do
    before do
      @user = FactoryBot.build(:user, :user_with_short_password)
      @user.valid?  
    end

    it "has :password error" do
      expect(@user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end
  end

  context "with non_unique email" do
    before do
      FactoryBot.create(:user, email: "tarou@tarou.com")
      @user = FactoryBot.build(:other_user, email: "tarou@tarou.com")
      @user.valid?  
    end
    it "has :email error" do
      expect(@user.errors[:email]).to include("has already been taken") 
    end
  end
end