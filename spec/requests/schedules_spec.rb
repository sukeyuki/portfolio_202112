require 'rails_helper'

RSpec.describe "Schedules", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/schedules/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/schedules/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/schedules/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
