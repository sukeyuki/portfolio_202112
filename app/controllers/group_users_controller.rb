class GroupUsersController < ApplicationController
  before_action :update_filter, only: [:update]
  before_action :destroy_filter, only: [:destroy]

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
  def group_user_update_params
    params.require(:group_user).permit(:role)
  end

  # update前のvalidation
  def update_filter
    group_user = GroupUser.find(params[:id])
    #編集者がadminでありかつ、編集されるuserが自分か権利がnormalの場合は編集可能
    return nil if current_user.editable?(group_user)
    flash[:alert] = "権限が間違っています。"
    redirect_to root_url
  end

  # destroy前のvalidation
  def destroy_filter
    group_user = GroupUser.find(params[:id])
    #編集されるuserが自分自身か、編集者がadminかつ編集されるuserがnormalなら削除可能
    return nil if current_user.deletable?(group_user)
    flash[:alert] = "権限が間違っています。"
    redirect_to root_url    
  end
end


