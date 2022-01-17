class GroupsController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    @group = current_user.groups.new(group_params)
    @group_user = GroupUser.new(user:current_user, group:@group,role:10, activated: true)
    ActiveRecord::Base.transaction do
      @group.save!
      @group_user.save!
    end

    rescue
      flash[:errors] = []
      flash[:errors] << @group.errors.messages
      flash[:errors] << @group_user.errors.messages

    ensure
      redirect_to root_path
  end

  def edit
    # FIXME: 全ての人がURLを記載することでグループedit画面に入ることができる状態
    @group = Group.find(params[:id])
    # debugger
    if GroupUser.where(group_id:@group.id).where(activated:true).map{|a|a.user_id}.include?(current_user.id)
      @search_users = User.all.where("search_name=?", users_search_params[:search]).where.not(id: @group.users.map(&:id)) unless users_search_params == {}
      session[:forwarding_url] = request.original_url if request.get?
    else
      redirect_to root_path
    end
  end

  def update
    @group = Group.find(params[:id])
    unless @group.update(group_params)
      flash[:errors] = @group.errors.messages
    end
    redirect_to root_path
  end

  private
  def group_params
    params.require(:group).permit(:name, :overview, :personal)
  end

  def users_search_params
    params.permit(:search)
  end
end
