require 'rails_helper'

RSpec.describe "GroupUsers", type: :request do

  before do
    @group = FactoryBot.create(:group)
    @user = FactoryBot.create(:user)
    @user.confirm
    sign_in @user
  end

  describe "POST /create" do
    it "returns http success" do
      params = {
        "user_id"=> @user.id,
        "group_id"=> @group.id
      }
      post group_users_url, params:{group_user: params}
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
    end
      
      it "can create one new group_user with valid data" do
      params = {
        "user_id"=> @user.id,
        "group_id"=> @group.id
      }
      expect{
      post group_users_url, params:{group_user: params}
      }.to change(GroupUser, :count).by(1)
      expect(response).to redirect_to root_path
    end

    it "cannot create new group_users with invalid data" do
      params = {
        "user_id"=> 100,
        "group_id"=> 100
      }
      # FIXME: invalidデータの1001はなんか微妙かも。なんかの拍子にvalidにならないか？
      expect{
      post group_users_url, params:{group_user: params}
      }.to change(GroupUser, :count).by(0)
      expect(response).to redirect_to root_path
      # FIXME: エラーの内容を確認するspecが必要？
    end
  end

  describe "POST /update" do
    it "returns http success" do
      group_user = FactoryBot.create(:group_user)
      params = {
        "role"=> 10
      }
      put group_user_url(group_user), params:{group_user: params}
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path      
      # TODO: パラメータを更新して、反映されているかどうかを確認するコードが欲しいが、良いテストが思いつかない。
    end
  end
end
