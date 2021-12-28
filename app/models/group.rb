class Group < ApplicationRecord
  validates :name, presence:true, length:{maximum:50}
  validates :overview, presence:true, length:{maximum:1000}
  has_many :schedules
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
end