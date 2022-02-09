class Schedule < ApplicationRecord
  validates :title, presence:true, length:{maximum:50}
  validates :contents, length:{maximum:1000}
  validates :start_at, presence:true
  validates :end_at,presence:true
  validate :start_end_history
  belongs_to :group

  # private
  def start_end_history
    if start_at != nil && end_at != nil
      if start_at >= end_at
        errors.add(:base, :term_is_missing)
      end
    end
  end
end