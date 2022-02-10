class GroupUser < ApplicationRecord
  validates :activated, inclusion:{ in: [true, false] }
  belongs_to :group
  belongs_to :user
  enum role: {admin:10, normal:20}
  scope :activated, -> {where(activated: true)}
  scope :non_activated, -> {where(activated: false)}
  scope :admin, -> {where(role: "admin")}
  scope :normal, -> {where(role: "normal",activated:true)}

  def destroy_myself
    if GroupUser.where(group_id: group_id).count == 1
      Group.find(group_id).destroy
    end
    destroy
  end
end