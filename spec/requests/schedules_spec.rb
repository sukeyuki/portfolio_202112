require 'rails_helper'

RSpec.describe "Schedules", type: :request do

  before do
    @user = FactoryBot.create(:user)
    @user.confirm
    sign_in @user
    get root_path
  end

  let(:group) { FactoryBot.create(:group)}

  describe "GET /index" do
    context "with valid data" do
      it "returns http success" do
        get schedules_url
        expect(response).to have_http_status(:success)
      end  

      # it "return http scuccess with first day data" do
      #   @params=


        
      # end
    end


  end

  describe "POST /create" do
    context "with valid data" do
      before do
        @params = FactoryBot.build(:schedule).attributes
      end

      it "returns http 302" do
        post schedules_url, params: {schedule: @params}
        expect(response).to have_http_status "302"
      end  

      it "redirect_to root_path" do
        post schedules_url, params: {schedule: @params}
        expect(response).to redirect_to root_path
      end  

      it "can add one schedule with valid data" do
        @params["group_id"] = group.id
        expect{
          post schedules_url, params: {schedule: @params}
        }.to change(Schedule, :count).by(1)
      end
    end

    context "with invalid data" do
      before do
        @params = FactoryBot.build(:schedule, :schedule_with_blank_attributes).attributes
      end

      it "returns http 302" do
        post schedules_url, params: {schedule: @params}
        expect(response).to have_http_status "302"
      end  

      it "redirect_to root_path" do
        post schedules_url, params: {schedule: @params}
        expect(response).to redirect_to root_path
      end

      it "cannot add schedules with invalid data" do
        expect{
          post schedules_url, params: {schedule: @params}
        }.to change(Schedule, :count).by(0)
      end
    end
  end

  describe "PUT /update" do
    before do
      @params = FactoryBot.build(:schedule, :other_valid_schedule).attributes
      @schedule = FactoryBot.create(:schedule)
    end

    it "returns http 302 with valid data" do
      put schedule_path(@schedule), params: {schedule:@params}
      expect(response).to have_http_status "302"
    end

    it "redirect_to root_path" do
      put schedule_path(@schedule), params: {schedule:@params}
      expect(response).to redirect_to root_path
    end
    # TODO: パラメータを更新して、反映されているかどうかを確認するコードが欲しいが、良いテストが思いつかない。
  end
end
