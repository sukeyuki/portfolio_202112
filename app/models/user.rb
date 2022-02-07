class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable, :trackable and :omniauthable
  after_create :create_personal_group


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  
  validates :name, presence:true, length:{ maximum:20}, format:{with:/[\w.]{0,20}/}
  validates :search_name, presence:true, length:{ maximum:20}, format:{with:/[\w.]{0,20}/}

  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users
  scope :with_active_group, -> (g) {joins(:group_users).merge(g.group_users.activated)}
  scope :with_not_active_group, -> (g) {joins(:group_users).merge(g.group_users.non_activated)}
  scope :admin_users_of, -> (g) {joins(:group_users).merge(g.group_users.admin)}
  scope :normal_users_of, -> (g) {joins(:group_users).merge(g.group_users.normal)}
  
  private
  def create_personal_group
    ActiveRecord::Base.transaction do
      group = Group.create!(name:"private", personal:true, overview:"my personal schedule")
      GroupUser.create!(group:group, user:self,role:10, activated: true)
    end
  end
end