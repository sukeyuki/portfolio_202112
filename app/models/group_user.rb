class GroupUser < ApplicationRecord
  validates :activated, inclusion:{ in: [true, false] }
  belongs_to :group
  belongs_to :user
  enum role: {admin:10, editor:20, viewer:30}
  scope :activated, -> {where(activated: true)}
  scope :non_activated, -> {where(activated: false)}
end