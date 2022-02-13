require 'rails_helper'

RSpec.describe "InviteUsers", type: :request do
  before do
    @group = FactoryBot.create(:group)
    @user1 = FactoryBot.create(:user)
    @user1.confirm
    sign_in @user1
    @user2 = FactoryBot.create(:user)
    @user2.confirm
  end
  
  describe "POST/invite" do
    context "with valid data" do
      before do
        @group_user1 = FactoryBot.create(:group_user, :as_admin_user, user:@user1, group:@group)
        get edit_group_url(@group)
        @params = FactoryBot.build(:group_user, :invite_user, group:@group, user:@user2).attributes
      end

      it "returns response 302" do
        post invite_users_url(@group_user2), params:{group_user: @params}
        expect(response).to have_http_status "302"  
      end

      it "redirect_to edit_url" do
        post invite_users_url(@group_user2), params:{group_user: @params}
        expect(response).to redirect_to edit_group_url(@group)
      end  

      it "add one group_user data" do
        expect{
          post invite_users_url(@group_user2), params:{group_user: @params}
        }.to change(GroupUser, :count).by(1)
      end
    end

    context "with invalid data" do
      before do
        @group_user1 = FactoryBot.create(:group_user, :as_admin_user, user:@user1, group:@group)
        get edit_group_url(@group)
        @params = FactoryBot.build(:group_user, group:@group,user_id:100).attributes
      end

      it "returns response 302" do
        post invite_users_url(@group_user2), params:{group_user: @params}
        expect(response).to have_http_status "302"  
      end

      it "redirect_to root_url" do
        post invite_users_url(@group_user2), params:{group_user: @params}
        expect(response).to redirect_to root_url
      end  

      it "cannot add one group_user data" do
        expect{
          post invite_users_url(@group_user2), params:{group_user: @params}
        }.to change(GroupUser, :count).by(0)
      end
    end

    context "editor has invalid role" do
      before do
        @group_user1 = FactoryBot.create(:group_user, :as_normal_user, user:@user1, group:@group)
        get edit_group_url(@group)
        @params = FactoryBot.build(:group_user, :invite_user, group:@group, user:@user2).attributes
      end

      it "returns response 302" do
        post invite_users_url(@group_user2), params:{group_user: @params}
        expect(response).to have_http_status "302"  
      end

      it "redirect_to root_url" do
        post invite_users_url(@group_user2), params:{group_user: @params}
        expect(response).to redirect_to root_url
      end  

      it "cannot add one group_user data" do
        expect{
          post invite_users_url(@group_user2), params:{group_user: @params}
        }.to change(GroupUser, :count).by(0)
      end
    end
  end

  describe "POST/reply" do
    context "with valid data" do 
      context "response:true" do
        before do
          @group_user2 = FactoryBot.create(:group_user, :as_admin_user, user:@user2, group:@group)
          @group_user1 = FactoryBot.create(:group_user, :invite_user, user:@user1, group:@group)
          @params = {id:@group_user1.id, response:"true"}
          get root_url
        end

        it "returns response 302" do
          put invite_user_url(@group_user1), params:@params
          expect(response).to have_http_status "302"  
        end

        it "redirect_to root_url" do
          put invite_user_url(@group_user1), params:@params
          expect(response).to redirect_to root_url
        end  

        it "add one group_user data" do
          expect{
            put invite_user_url(@group_user1), params:@params
          }.to change(GroupUser.where(activated:true), :count).by(1)
        end
      end

      context "response:false" do
        before do
          @group_user2 = FactoryBot.create(:group_user, :as_admin_user, user:@user2, group:@group)
          @group_user1 = FactoryBot.create(:group_user, :invite_user, user:@user1, group:@group)
          @params = {id:@group_user1.id, response:"false"}
          get root_url
        end

        it "returns response 302" do
          put invite_user_url(@group_user1), params:@params
          expect(response).to have_http_status "302"  
        end

        it "redirect_to root_url" do
          put invite_user_url(@group_user1), params:@params
          expect(response).to redirect_to root_url
        end  

        it "delete one group_user data" do
          expect{
            put invite_user_url(@group_user1), params:@params
          }.to change(GroupUser, :count).by(-1)
        end
      end
    end

    context "with invalid data" do
      before do
        @group_user2 = FactoryBot.create(:group_user, :as_admin_user, user:@user2, group:@group)
        @group_user1 = FactoryBot.create(:group_user, :invite_user, user:@user1, group:@group)
        get root_url
      end

      context "invalid response" do
        before do
          @params = {id:@group_user1.id, response:"nil", }
        end

        it "returns response 302" do
          put invite_user_url(@group_user1), params:@params
          expect(response).to have_http_status "302"  
        end

        it "redirect_to root_url" do
          put invite_user_url(@group_user1), params:@params
          expect(response).to redirect_to root_url
        end  

        it "cannot add one group_user data" do
          expect{
            put invite_user_url(@group_user1), params:@params
          }.to change(GroupUser, :count).by(0)
        end
      end

      # context "invalid id" do
      #   before do
      #     @params = {id:@group_user1.id, response:"true", }
      #   end

      #   it "returns response 302" do
      #     put invite_user_url(100), params:@params
      #     expect(response).to have_http_status "302"  
      #   end

      #   it "redirect_to root_url" do
      #     put invite_user_url(100), params:@params
      #     expect(response).to redirect_to root_url
      #   end  

      #   it "cannot add one group_user data" do
      #     expect{
      #       put invite_user_url(100), params:@params
      #     }.to change(GroupUser, :count).by(0)
      #   end
      # end
    end
  end
end