require 'rails_helper'

RSpec.describe "Groups", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @user.confirm
    sign_in @user
  end

  describe "POST /create" do
    it "returns http 302" do
      params = FactoryBot.build(:group).attributes
      post groups_url, params:{group: params}
      expect(response).to redirect_to root_path
    end

    it "can create one new group with valid data" do
      params = FactoryBot.build(:group).attributes
      expect{
        post groups_url, params:{group: params}
      }.to change(Group, :count).by(1)
    end

    it "can create one new group and one group_user" do
      params = FactoryBot.build(:group).attributes
      expect{
        post groups_url, params:{group: params}
      }.to change(GroupUser, :count).by(1)
      expect(response).to redirect_to root_path
    end

    it "cannot create one new group with invalid data" do
      params = FactoryBot.build(:group, :group_with_blank_attributes).attributes
      expect{
        post groups_url, params:{group: params}
      }.to change(Group, :count).by(0)
      expect(response).to redirect_to root_path
      # FIXME: エラーの内容を確認するspecが必要？
    end
  end

  describe "PUT /update" do
    it "returns http 302 with valid data" do
      params = FactoryBot.build(:group, :other_valid_group).attributes
      group = FactoryBot.create(:group)
      put group_url(group), params: {group:params}
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
    end
    # TODO: パラメータを更新して、反映されているかどうかを確認するコードが欲しいが、良いテストが思いつかない。
  end
end
