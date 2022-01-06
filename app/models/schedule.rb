class Schedule < ApplicationRecord
  validates :title, presence:true, length:{maximum:50}
  validates :contents, presence:true, length:{maximum:1000}
  validates :start_at, presence:true
  validates :end_at,presence:true

  belongs_to :group
end