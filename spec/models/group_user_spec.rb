require 'rails_helper'

RSpec.describe GroupUser, type: :model do
  it "generte associated data from a factory" do
    group_user = FactoryBot.build(:group_user)
    group_user.valid?
    expect(group_user).to be_valid
    expect(group_user.user).to be_valid
    expect(group_user.group).to be_valid
  end

  it "is invalid with blank attributes" do
    group_user = FactoryBot.build(:group_user, :group_user_with_blank_attributesa)
    group_user.valid?
    expect(group_user.errors[:user_id]).to include("can't be blank")
    expect(group_user.errors[:group_id]).to include("can't be blank")
    expect(group_user.errors[:activated]).to include("is not included in the list")
  end

end
