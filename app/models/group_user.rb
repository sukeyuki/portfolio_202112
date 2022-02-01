class GroupUser < ApplicationRecord
  validates :activated, inclusion:{ in: [true, false] }
  belongs_to :group
  belongs_to :user
  scope :activated, -> {where(activated: true)}
  scope :non_activated, -> {where(activated: false)}

  def destroy_myself
    if GroupUser.where(group_id: group_id).count == 1
      Group.find(group_id).destroy
    end
    destroy
  end
end