class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  
  validates :name, presence:true, length:{ maximum:20}, format:{with:/[\w.]{0,20}/}
  validates :search_name, presence:true, length:{ maximum:20}, format:{with:/[\w.]{0,20}/}

  has_many :schedules, dependent: :destroy
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users

  # user = User.new(name:"tarou", search_name:"tarou",email:"tarou@tarou.com", password:123456789, password_confirmation:123456789)
  # group = user.groups.new(name:"jobs", overview:"aaaaa", personal:true)
  # group = Group.new(name:"jobs", overview:"aaaaa", personal:true)
end