class GroupUsersController < ApplicationController
  def create
    @group_user = GroupUser.new(group_user_params)
    # debugger
    if @group_user.valid?
      @group_user.save
    else
      flash[:errors] = @group_user.errors.messages
    end
    redirect_to controller: :schedules, action: :index    
  end

  def update
    @group_user = GroupUser.find(params[:id])
    unless @group_user.update(group_user_params)
      flash[:errors] = @group_user.errors.messages
    end
    redirect_to controller: :schedules, action: :index    
  end
end


private
def group_user_params
  params.require(:group_user).permit(:user_id, :group_id, :activated)
end