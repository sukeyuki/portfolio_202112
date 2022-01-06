class GroupUser < ApplicationRecord
  validates :activated, inclusion:{ in: [true, false] }
  belongs_to :group
  belongs_to :user
end