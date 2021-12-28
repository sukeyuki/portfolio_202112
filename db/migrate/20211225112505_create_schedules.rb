class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.string :title
      t.integer :user_id
      t.integer :group_id
      t.string :contents
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
