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
  def group_user_create_params
    params.require(:group_user).permit(:user_id, :group_id)
  end

  def group_user_update_params
    params.require(:group_user).permit(:role)
  end

  # update前のvalidation
  def update_filter
    #editor_role 編集者の権利
    #user_role 編集されるuserの権利
    #my_self? 編集者と編集される人が同じかどうか
    group_id = GroupUser.find(params[:id]).group_id    
    editor_role = GroupUser.find_by(group_id:group_id, user:current_user).role
    user_role = GroupUser.find(params[:id]).role
    myself_or_not = GroupUser.find(params[:id]).user_id == current_user.id

    #編集者がadminでありかつ、編集されるuserが自分か権利がnormalの場合は編集可能
    unless editor_role == "admin" && (myself_or_not || user_role=="normal")
      flash[:alert] = "権限が間違っています。"
      return redirect_to root_url
    end
  end

  # destroy前のvalidation
  def destroy_filter
    #editor_role 編集者の権利
    #user_role 編集されるuserの権利
    #my_self? 編集者と編集される人が同じかどうか
    group_id = GroupUser.find(params[:id]).group_id    
    editor_role = GroupUser.find_by(group_id:group_id, user:current_user).role
    user_role = GroupUser.find(params[:id]).role
    myself_or_not = GroupUser.find(params[:id]).user_id == current_user.id

    #編集されるuserが自分自身か、編集者がadminかつ編集されるuserがnormalなら削除可能
    unless myself_or_not || (editor_role=="admin" && user_role=="normal")
      flash[:alert] = "権限が間違っています。"
      return redirect_to root_url
    end
  end
end


