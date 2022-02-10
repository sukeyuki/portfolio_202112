require 'rails_helper'

RSpec.describe "GroupUsers", type: :request do

  before do
    @group = FactoryBot.create(:group)
    @user = FactoryBot.create(:user)
    @user.confirm
    sign_in @user
  end

  describe "POST /create" do
    context "with valid data" do
      before do
        @params = {
          "user_id"=> @user.id,
          "group_id"=> @group.id
        }
      end

      it "returns http 302" do
        post group_users_url, params:{group_user: @params}
        expect(response).to have_http_status "302"  
      end
      
      it "redirect_to group_edit_url" do
        post group_users_url, params:{group_user: @params}
        expect(response).to redirect_to edit_group_url(@group)
      end  

      it "can create one new group_user with valid data" do
        expect{
          post group_users_url, params:{group_user: @params}
          }.to change(GroupUser, :count).by(1)    
      end
    end
      
    context "with invalid data" do
      before do
        @params = {
          "user_id"=> 100,
          "group_id"=> 100
        }  
      end
     
      it "returns http success" do
        post group_users_url, params:{group_user: @params}
        expect(response).to have_http_status "302"  
      end

      it "redirect_to root_path" do
        post group_users_url, params:{group_user: @params}
        expect(response).to redirect_to root_path
      end  

      it "cannot create new group_users with invalid data" do
        expect{
        post group_users_url, params:{group_user: @params}
        }.to change(GroupUser, :count).by(0)
      end
    end
  end

  describe "POST /update" do
    context "with valid data" do
      context "with activated true" do
        before do
          @group_user = FactoryBot.create(:group_user)
          @params = {
            "activated"=> true
          }
          get root_path
        end

        it "returns http success" do
          patch group_user_url(@group_user), params:{group_user: @params}
          expect(response).to have_http_status "302"  
        end

        it "redirect_to root_path" do
          patch group_user_url(@group_user), params:{group_user: @params}
          expect(response).to redirect_to root_path
        end  
      end
    end
  end

  describe "POST /destroy" do
    before do
      @group_user = FactoryBot.create(:group_user, :activated_true)
      get root_path
    end

    it "delete one group_user" do
      expect{
        delete group_user_url(@group_user)
      }.to change(GroupUser, :count).by(-1)
    end

    it "redirect_to root_path" do
      delete group_user_url(@group_user)
      expect(response).to redirect_to root_path
    end
  end

end
