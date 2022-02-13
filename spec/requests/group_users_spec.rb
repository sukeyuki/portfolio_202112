require 'rails_helper'

RSpec.describe "GroupUsers", type: :request do

  before do
    @group = FactoryBot.create(:group)
    @user1 = FactoryBot.create(:user)
    @user1.confirm
    sign_in @user1
    @user2 = FactoryBot.create(:user)
    @user2.confirm
  end

  describe "POST /update" do
    context "with valid data" do
      context "change to admin" do
        before do
          @group_user1 = FactoryBot.create(:group_user, :as_admin_user, user:@user1, group:@group)
          @group_user2 = FactoryBot.create(:group_user, :as_normal_user, user:@user2, group:@group)
          get edit_group_url(@group)
          @params = FactoryBot.build(:group_user, :as_admin_user).attributes
        end

        it "returns response 302" do
          patch group_user_url(@group_user2), params:{group_user: @params}
          expect(response).to have_http_status "302"  
        end

        it "redirect_to edit_url" do
          patch group_user_url(@group_user2), params:{group_user: @params}
          expect(response).to redirect_to edit_group_url(@group)
        end  
      end
    end

    context "with invalid data" do
      context "with nil data" do
        before do
          @group_user1 = FactoryBot.create(:group_user, :as_admin_user, user:@user1, group:@group)
          @group_user2 = FactoryBot.create(:group_user, :as_normal_user, user:@user2, group:@group)
          get edit_group_url(@group)
          @params = FactoryBot.build(:group_user, :group_user_with_blank_attributes).attributes
        end

        it "returns http 302" do
          patch group_user_url(@group_user2), params:{group_user: @params}
          expect(response).to have_http_status "302"  
        end

        it "redirect_to edit_url" do
          patch group_user_url(@group_user2), params:{group_user: @params}
          expect(response).to redirect_to edit_group_url(@group)
        end  
      end

      context "with editor who has invalid role" do
        before do
          @group_user1 = FactoryBot.create(:group_user, :as_normal_user, user:@user1, group:@group)
          @group_user2 = FactoryBot.create(:group_user, :as_normal_user, user:@user2, group:@group)
          get edit_group_url(@group)
          @params = FactoryBot.build(:group_user, :as_admin_user).attributes
        end

        it "returns http 302" do
          patch group_user_url(@group_user2), params:{group_user: @params}
          expect(response).to have_http_status "302"  
        end

        it "redirect_to root_url" do
          patch group_user_url(@group_user2), params:{group_user: @params}
          expect(response).to redirect_to root_url
        end  
      end
    end
  end

  describe "POST /destroy" do

    context "with valid data" do
      before do
        @group_user1 = FactoryBot.create(:group_user, :as_admin_user, user:@user1, group:@group)
        @group_user2 = FactoryBot.create(:group_user, :as_normal_user, user:@user2, group:@group)
        get edit_group_url(@group)
      end
  
      it "delete one group_user" do
        expect{
          delete group_user_url(@group_user2)
        }.to change(GroupUser, :count).by(-1)
      end

      it "redirect_to edit_url" do
        delete group_user_url(@group_user2)
        expect(response).to redirect_to edit_group_url(@group)
      end
    end

    context "with editor who has invalid role" do
      before do
        @group_user1 = FactoryBot.create(:group_user, :as_normal_user, user:@user1, group:@group)
        @group_user2 = FactoryBot.create(:group_user, :as_normal_user, user:@user2, group:@group)
        get edit_group_url(@group)
      end    

      it "cannot delete one group_user" do
        expect{
          delete group_user_url(@group_user2)
        }.to change(GroupUser, :count).by(0)
      end

      it "redirect_to root_url" do
        delete group_user_url(@group_user2)
        expect(response).to redirect_to root_url
      end
    end
  end
end
