class InviteUsersController < ApplicationController
  before_action :invite_filter, only: [:invite]

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
      group_user.update(activated:response_bool[:response])
    elsif response_bool[:response] == "false"
      #拒否
      GroupUser.find(params[:id]).destroy_myself      
    else
      flash[:alert] = "正しくない値が選択されています。"
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

  # invite前のvalidation
  def invite_filter
    group_id =  group_user_id["group_id"].to_i
    # 自分の権限がadminの場合、invite可能。
    unless GroupUser.find_by(group_id:group_id, user:current_user)&.role == "admin"
      flash[:alert] = "権限が間違っています。"
      return redirect_to root_url
    end
  end
end
