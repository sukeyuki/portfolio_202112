require 'rails_helper'

RSpec.describe User, type: :model do
  
  it "is valid with correct data" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "is invalid with blank attributes" do
    user = FactoryBot.build(:user, :user_with_blank_name_and_userid_email)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
    expect(user.errors[:user_id]).to include("can't be blank")
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid with short password" do
    user = FactoryBot.build(:user, :user_with_short_password)
    user.valid?
    expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
  end

  it "is invalid with non_unique email" do
    FactoryBot.create(:user, email: "tarou@tarou.com")
    user = FactoryBot.build(:other_user, email: "tarou@tarou.com")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken") 
  end
end