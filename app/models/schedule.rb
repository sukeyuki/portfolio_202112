class Schedule < ApplicationRecord
  validates :title, presence:true, length:{maximum:50}
  validates :contents, presence:true, length:{maximum:1000}
  validates :start_at, presence:true
  validates :end_at,presence:true
  validate :start_end_history
  belongs_to :group

  # private
  def start_end_history
    if start_at != nil && end_at != nil
      if start_at > end_at
        errors.add(:base, :term_is_missing)
        # errors.add(:start_at, :term_is_missing)
        # errors.add(:start_at, "set start_time past of end_time")#ラベルを渡すとそれが表示される。
        # errors.add(:end_at, "set end_time future of start_time")#ラベルを渡すとそれが表示される。
      end
    end
  end
end