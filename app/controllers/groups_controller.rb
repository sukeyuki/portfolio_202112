class GroupsController < ApplicationController
  before_action :authenticate_user!

  def new
    @group = Group.new
  end

  def create
    group = current_user.groups.new(group_params)
    group.personal = false
    group_user = GroupUser.new(user:current_user, group:group, activated: true)
    ActiveRecord::Base.transaction do
      group.save!
      group_user.save!
    end

    rescue
      flash[:group_create_error] = group.errors.full_messages

    ensure
      redirect_to root_path
  end

  def edit
    @user = current_user
    @group = Group.find_by_id(params[:id])
    #グループに参加していない人はrootにリダイレクト
    if @group!=nil && GroupUser.where(group_id:@group.id).where(activated:true).map{|a|a.user_id}.include?(current_user.id)
      @search_users = User.all.where("search_name=?", users_search_params[:search]).where.not(id: @group.users.map(&:id)) unless users_search_params == {}
    else
      redirect_to root_path
    end
  end

  def update
    group = Group.find(params[:id])
    unless group.update(group_params)
      flash[:group_update_error] = group.errors.full_messages
    end
    redirect_to edit_group_url(group)
  end

  private
  def group_params
    params.require(:group).permit(:name, :overview, :personal)
  end

  def users_search_params
    params.permit(:search)
  end
end
