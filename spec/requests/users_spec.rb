require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "POST sign_in" do
    it "returns http success" do
      user = FactoryBot.create(:user)
      params = user.attributes
      post user_session_url, params:{user: params}
      expect(response).to have_http_status(:success)
      expect redirect_to root_url
    end
  end

  describe "POST sign_up" do
    it "returns http success" do
      params = FactoryBot.build(:user).attributes
      post user_registration_url, params:{user: params}
      expect(response).to have_http_status(:success)
      expect redirect_to root_url
    end
  end
# TODO: deviseは軽くしか書いていない。これ以上のテストは必要か？
end
