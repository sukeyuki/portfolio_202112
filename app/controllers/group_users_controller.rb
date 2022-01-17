class GroupUsersController < ApplicationController
  def create
    @group_user = GroupUser.new(group_user_create_params)
    unless @group_user.save
      flash[:errors] = @group_user.errors.messages
    end
    redirect_to edit_group_url(group_user_create_params[:group_id])
  end

  def update
    #メイン画面のグループリクエストを拒否したらデータを消す処理に移行 
    if group_user_update_params[:activated]=="delete"
      # return redirect_to action: :destroy
      # FIXME: redirect_toを使用出来なかったため下記のように記載したが間違っている気がする。
      return self.destroy
    end
    @group_user = GroupUser.find(params[:id])
    unless @group_user.update(group_user_update_params)
      flash[:errors] = @group_user.errors.messages
    end
    redirect_to(session[:forwarding_url])
    session.delete(:forwarding_url)
  end

  def destroy
    GroupUser.find(params[:id]).destroy
    redirect_to(session[:forwarding_url])
    session.delete(:forwarding_url)
  end

  private
  def group_user_create_params
    params.require(:group_user).permit(:user_id, :group_id, :role)
  end

  def group_user_update_params
    params.require(:group_user).permit(:activated, :role)
  end
end


