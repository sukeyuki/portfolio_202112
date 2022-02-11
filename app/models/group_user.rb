class GroupUser < ApplicationRecord
  validates :activated, inclusion:{ in: [true, false] }
  belongs_to :group
  belongs_to :user
  enum role: {admin:10, normal:20}
  scope :activated, -> {where(activated: true)}
  scope :non_activated, -> {where(activated: false)}
  scope :admin, -> {where(role: "admin")}
  scope :normal, -> {where(role: "normal",activated:true)}

  def destroy_myself
    # admin_user_count: 消去するgoup_userグループのアドミンユーザー数
    # active_user_count: 消去するgroup_userグループのユーザー数
    # user_role: 消去するgroup_userユーザーのrole
    group = Group.find(self.group_id)
    admin_user_count = User.admin_users_of(group).count
    active_user_count = User.with_active_group(group).count
    user_role = User.find(self.user_id).role
    #自分が"normal"であるか、admin保有者が2人以上いるか、あなたがそのグループの最後の一人の場合削除できます。
    if user_role == "normal" || admin_user_count >=2 || active_user_count ==1
      # 自分が最後の一人の場合、そのグループを削除する。
      if active_user_count == 1
        Group.find(group_id).destroy
      end
      destroy
    else
      errors.add(:base, :group_user_count_valid)
      return redirect_to root_url
    end
    
  end
end