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

      it "return http scuccess with group checkbox data" do
        @params = {
          "checkbox":"1",
        }
        get schedules_url
        expect(response).to have_http_status(:success)
      end

      it "return http scuccess with first day data" do
        @params = {
          'start_at':"2022-01-01",
        }
        get schedules_url
        expect(response).to have_http_status(:success)
      end

      it "return http scuccess with first day and grop checkbox data" do
        @params = {
          'start_at':"2022-01-01",
          "checkbox":"1,2",
          "checkbox_search":"true",
          "first_day_search":"true"
        }
        get schedules_url
        expect(response).to have_http_status(:success)
      end
    end

    context "csv_output" do
      before do
        FactoryBot.create(:schedule)
        @params = {
          'start_at':"2022-02-01",
          "checkbox":"1,2",
          "checkbox_search":"true",
          "first_day_search":"true"
        }
      end

      it "have csv data" do
        get schedules_url(@params.merge({format: "csv"}))
        expect(response.headers["Content-Type"]).to include "text/csv"
      end

      it "have valid title" do
        get schedules_url(@params.merge({format: "csv"}))
        expect(response.headers["Content-Disposition"]).to include "test.csv"

      end
    end
  end

  describe "POST /create" do
    context "with valid data" do
      before do
        @params = FactoryBot.build(:schedule).attributes
      end

      it "returns http 200" do
        post schedules_url, params: {schedule: @params}, xhr:true
        expect(response).to have_http_status "200"
      end  

      it "can add one schedule with valid data" do
        @params["group_id"] = group.id
        expect{
          post schedules_url, params: {schedule: @params}, xhr:true
        }.to change(Schedule, :count).by(1)
      end
    end

    context "with invalid data" do
      before do
        @params = FactoryBot.build(:schedule, :schedule_with_blank_attributes).attributes
      end

      it "returns http 200" do
        post schedules_url, params: {schedule: @params}, xhr:true
        expect(response).to have_http_status "200"
      end  

      it "cannot add schedules with invalid data" do
        expect{
          post schedules_url, params: {schedule: @params}, xhr:true
        }.to change(Schedule, :count).by(0)
      end
    end
  end

  describe "PUT /update" do
    before do
      @params = FactoryBot.build(:schedule, :other_valid_schedule).attributes
      @schedule = FactoryBot.create(:schedule)
    end

    it "returns http 200 with valid data" do
      put schedule_url(@schedule), params: {schedule:@params}, xhr:true
      expect(response).to have_http_status "200"
    end
  end

  describe "PUT /destroy" do
    before do
      @params = FactoryBot.build(:schedule).attributes
      @schedule = FactoryBot.create(:schedule)
    end

    it "delete one schedule" do
      expect{
        delete schedule_url(@schedule), params: {schedule: @params}
      }.to change(Schedule, :count).by(-1)
    end

  end
end
