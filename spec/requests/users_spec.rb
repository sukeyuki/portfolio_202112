require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "POST sign_in" do

    context "with valid data" do
      before do
        @params = FactoryBot.create(:user).attributes
      end

      it "returns http success" do
        post user_session_url, params:{user: @params}
        expect(response).to have_http_status(:success)
      end  

      it "redirect_to root_path" do
        post user_session_url, params:{user: @params}
        expect redirect_to root_url
      end
    end
  end

  describe "POST sign_up" do
    before do
      @params = FactoryBot.build(:user).attributes
    end
    it "returns http success" do
      post user_registration_url, params:{user: @params}
      expect(response).to have_http_status(:success)
    end

    it "redirect_to root_path" do
      post user_registration_url, params:{user: @params}
      expect redirect_to root_url
    end
  end
# TODO: deviseは軽くしか書いていない。これ以上のテストは必要か？
end
