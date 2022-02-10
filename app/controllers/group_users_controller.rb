class GroupUsersController < ApplicationController

  # PATCH /group_users/:id
  def update
    group_user = GroupUser.find(params[:id])
    unless group_user.update(group_user_update_params)
      flash[:alert] = group_user.errors.full_messages
    end
    redirect_to edit_group_url(group_user.group_id)
  end

  # DELETE /group_users/:id
  def destroy
    gu = GroupUser.find(params[:id]).destroy_myself
    redirect_to edit_group_url(gu.group_id)
  end

  private
  def group_user_create_params
    params.require(:group_user).permit(:user_id, :group_id)
  end

  def group_user_update_params
    params.require(:group_user).permit(:role)
  end
end


