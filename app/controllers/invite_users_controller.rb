class InviteUsersController < ApplicationController

  # POST /invite_users
  def invite
    #group_edit画面で発動
    group_user = GroupUser.new(group_user_id)
    unless group_user.save
      flash[:alert] = group_user.errors.full_messages
      #エラー発生時はrootにリダイレクト。発生しないはず。
      return redirect_to root_url
    end
    redirect_to edit_group_url(group_user_id[:group_id])
  end

  # POST /invite_user/:id
  def reply
    # schedule/index画面にて発動
    if response_bool[:response] == "true"
      #承認
      group_user = GroupUser.find(params[:id])
      unless group_user.update(activated:response_bool[:response])
        flash[:alert] = group_user.errors.full_messages
      end
    else
      #拒否
      GroupUser.find(params[:id]).destroy_myself
    end
    redirect_to root_url
  end

  private
  def group_user_id
    params.require(:group_user).permit(:user_id,:group_id)
  end

  def response_bool
    params.permit(:response)
  end
end
