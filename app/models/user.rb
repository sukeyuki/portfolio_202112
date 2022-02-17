class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable, :trackable and :omniauthable
  after_create :create_personal_group


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  
  validates :name, presence:true, length:{ maximum:20}, format:{with:/[\w.]{0,20}/}
  validates :search_name, uniqueness: true, presence:true, length:{ maximum:20}, format:{with:/[\w.]{0,20}/}

  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users
  scope :with_active_group, -> (g) {joins(:group_users).merge(g.group_users.activated)}
  scope :with_not_active_group, -> (g) {joins(:group_users).merge(g.group_users.non_activated)}
  scope :admin_users_of, -> (g) {joins(:group_users).merge(g.group_users.admin)}
  scope :normal_users_of, -> (g) {joins(:group_users).merge(g.group_users.normal)}
  

  def editable?(group_user)
    #editor_role 編集者の権利
    #user_role 編集されるuserの権利
    #my_self_or_not 編集者と編集される人が同じかどうか
    group_id = group_user.group_id    
    editor_role = GroupUser.find_by(group_id:group_id, user:self)&.role
    user_role = group_user.role
    myself_or_not = group_user.user_id == self.id
    #編集者がadminでありかつ、編集されるuserが自分か権利がnormalの場合は編集可能
    if editor_role == "admin" && (myself_or_not || user_role=="normal")
      return true
    else
      return false
    end
  end

  def deletable?(group_user)
    #editor_role 編集者の権利
    #user_role 削除されるuserの権利
    #myself_or_not 編集者と削除される人が同じかどうか
    group_id = group_user.group_id    
    editor_role = GroupUser.find_by(group_id:group_id, user:self)&.role
    user_role = group_user.role
    myself_or_not = group_user.user_id == self.id
    #削除されるuserが自分自身か、編集者がadminかつ削除されるuserがnormalなら削除可能
    if myself_or_not || (editor_role=="admin" && user_role=="normal")
      return true
    else
      return false
    end
  end

  private
  def create_personal_group
    ActiveRecord::Base.transaction do
      group = Group.create!(name:"private", personal:true, overview:"my personal schedule")
      GroupUser.create!(group:group, user:self,role:10, activated: true)
    end
  end

end