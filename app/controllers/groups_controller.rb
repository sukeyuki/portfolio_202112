class GroupsController < ApplicationController
  def create
    @group = current_user.groups.new(group_params)
    @group_user = GroupUser.new(user:current_user, group:@group,role:10)
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

  def update
    @group = Group.find(params[:id])
    unless @group.update(group_params)
      flash[:errors] = @group.errors.messages
    end
    redirect_to root_path
  end
end


private
def group_params
  params.require(:group).permit(:name, :overview, :personal)
end