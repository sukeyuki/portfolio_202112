class GroupUsersController < ApplicationController
  # def create
  #   group_user = GroupUser.new(group_user_create_params)
  #   unless group_user.save
  #     flash[:alert] = group_user.errors.full_messages
  #     return redirect_to root_url
  #   end
  #   redirect_to edit_group_url(group_user_create_params[:group_id])
  # end

  def update
    group_user = GroupUser.find(params[:id])
    unless group_user.update(group_user_update_params)
      flash[:alert] = group_user.errors.full_messages
    end
    redirect_to edit_group_url(group_user.group_id)
  end

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


