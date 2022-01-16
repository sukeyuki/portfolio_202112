class GroupUsersController < ApplicationController
  def create
    @group_user = GroupUser.new(group_user_create_params)
    unless @group_user.save
      flash[:errors] = @group_user.errors.messages
    end
    redirect_to edit_group_url(group_user_create_params[:group_id])
  end

  def update
    @group_user = GroupUser.find(params[:id])
    unless @group_user.update(group_user_update_params)
      flash[:errors] = @group_user.errors.messages
    end
    redirect_to root_path
  end

  def destroy
    g_id = GroupUser.find(params[:id]).group_id
    GroupUser.find(params[:id]).destroy
    redirect_to edit_group_url(g_id)
  end

  private
  def group_user_create_params
    params.require(:group_user).permit(:user_id, :group_id, :role)
  end

  def group_user_update_params
    params.require(:group_user).permit(:activated, :role)
  end
end


