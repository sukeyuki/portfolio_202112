require 'rails_helper'

RSpec.describe "Schedules", type: :request do

  before do
    @user = FactoryBot.create(:user)
    @user.confirm
    sign_in @user
  end


  let(:group) { FactoryBot.create(:group)}


  describe "GET /index" do
    it "returns http success" do
      get schedules_url
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "returns http 302" do
      # FIXME: paramsのデータはなくても動きそう。params必要ないか？そもそもこのテストも必要ないか？
      params = FactoryBot.build(:schedule).attributes
      post schedules_url, params: {schedule: params}
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
    end


      # # FIXME: 下記テストが通らないが、理由がわからない。
      # debugger
      # schedule = FactoryBot.build(:schedule)


    it "can add one schedule with valid data" do
      params = FactoryBot.build(:schedule).attributes
      # params["group_id"] = 1
      params["group_id"] = group.id

      expect{
        post schedules_url, params: {schedule: params}
      }.to change(Schedule, :count).by(1)
      expect(response).to redirect_to root_path
    end

    it "cannot add schedules with invalid data" do
      params = FactoryBot.build(:schedule, :schedule_with_blank_attributes).attributes
      expect{
        post schedules_url, params: {schedule: params}
      }.to change(Schedule, :count).by(0)
      expect(response).to redirect_to root_path
      # FIXME: エラーの内容を確認するspecが必要？
    end
  end

  describe "PUT /update" do
    it "returns http 302 with valid data" do
      params = FactoryBot.build(:schedule, :other_valid_schedule).attributes
      schedule = FactoryBot.create(:schedule)
      put schedule_path(schedule), params: {schedule:params}
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
    end
    # TODO: パラメータを更新して、反映されているかどうかを確認するコードが欲しいが、良いテストが思いつかない。
  end
end
