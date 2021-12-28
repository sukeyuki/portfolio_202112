class GroupUser < ApplicationRecord
  validates :user_id, presence:true
  validates :group_id, presence:true
  validates :activated, inclusion:{ in: [true, false] }
  belongs_to :group
  belongs_to :user
end