class Group < ApplicationRecord
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable, :confirmable
  validates :name, presence:true, length:{maximum:50}
  validates :overview, length:{maximum:1000}
  validates :personal, inclusion:{ in: [true, false] }
  has_many :schedules, dependent: :destroy
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  scope :with_active_user, -> (u) {joins(:group_users).merge(u.group_users.activated)}
  scope :with_not_active_user, -> (u) {joins(:group_users).merge(u.group_users.non_activated)}
end