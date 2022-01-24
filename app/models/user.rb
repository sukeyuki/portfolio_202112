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

  
  private
  def create_personal_group
    ActiveRecord::Base.transaction do
      group = Group.create!(name:"private", personal:true, overview:"my personal scuedule")
      GroupUser.create!(group:group, user:self,role:10, activated: true)
      # group = groups.create!(name:"private", personal:true, overview:"my personal scuedule")
      # group = user1.groups.new(name:"private", personal:true, overview:"my personal scuedule")
      # GroupUser.find_by(group:group, user:self).update(role:10, activated: true)
    end
  end
end