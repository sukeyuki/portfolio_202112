class GroupsController < ApplicationController
  def create
    @group = current_user.groups.new(group_params)
    if @group.valid?
      @group.users << current_user
      @group.save
    else
      flash[:errors] = @group.errors.messages
    end
    redirect_to controller: :schedules, action: :index
  end

  def update
    @group = Group.find(params[:id])
    debugger
    unless @group.update(group_params)
      flash[:errors] = @group.errors.messages
    end
    redirect_to controller: :schedules, action: :index
  end
end


private
def group_params
  params.require(:group).permit(:name, :overview, :personal)
end