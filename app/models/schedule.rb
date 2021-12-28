class Schedule < ApplicationRecord
  validates :title, presence:true, length:{maximum:50}
  validates :user_id, presence:true
  validates :group_id, presence:true
  validates :contents, presence:true, length:{maximum:1000}
  validates :start_at, presence:true
  validates :end_at,presence:true

  belongs_to :user
  belongs_to :group
end