require 'rails_helper'

RSpec.describe "Groups", type: :request do

  before do
    @user = FactoryBot.create(:user)
    @user.confirm
    sign_in @user
  end

  describe "POST /create" do
    context "with valid data" do
      before do
        @params = FactoryBot.build(:group).attributes
      end

      it "returns http 200" do
        post groups_url, params:{group: @params}, xhr:true
        expect(response).to have_http_status "200" 
      end  

      it "can create one new group with valid data" do
        expect{
          post groups_url, params:{group: @params}, xhr:true
        }.to change(Group, :count).by(1)
      end  
    end

    context "with invalid data" do
      before do
        @params = FactoryBot.build(:group, :group_with_blank_attributes).attributes
      end
           
      it "returns http 200" do
        post groups_url, params:{group: @params}, xhr:true
        expect(response).to have_http_status "200"  
      end

      it "cannot create one new group with invalid data" do
        expect{
          post groups_url, params:{group: @params}, xhr:true
        }.to change(Group, :count).by(0)
      end  
    end
  end

  describe "GET /edit" do
    before do
      @group = @user.groups.create(FactoryBot.build(:group).attributes)
    end

    context "with valid data" do
      it "returns http 200" do
        GroupUser.find_by(group:@group,user:@user).update(activated:true, role:"admin")
        get edit_group_url(@group)
        expect(response).to have_http_status "200"
      end
    end

    context "with invalid data" do
      it "returns http 302" do
        get edit_group_url(@group)
        expect(response).to have_http_status "302"
      end

      it "redirect to root" do
        get edit_group_url(@group)
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "PUT /update" do
    before do
      @group = FactoryBot.create(:group)
      FactoryBot.create(:group_user, :as_admin_user, user:@user, group:@group)
      get edit_group_url(@group)
    end

    context "with valid data" do
      before do
        @params = FactoryBot.build(:group, :other_valid_group).attributes
      end

      it "returns http 302 with valid data" do
        put group_url(@group), params: {group:@params}
        expect(response).to have_http_status "302"
      end

      it "redirect_to edit_group_url" do
        put group_url(@group), params: {group:@params}
        expect(response).to redirect_to edit_group_url(@group)
      end
    end

    context "with invalid data" do
      before do
        @params = FactoryBot.build(:group, :group_with_blank_attributes).attributes
      end

      it "returns http 302 with valid data" do
        put group_url(@group), params: {group:@params}
        expect(response).to have_http_status "302"
      end

      it "redirect_to edit_group_url" do
        put group_url(@group), params: {group:@params}
        expect(response).to redirect_to edit_group_url(@group)
      end
    end
  end
end