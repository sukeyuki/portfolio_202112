class CreateGroupUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :group_users do |t|
      t.integer :user_id
      t.integer :group_id
      t.boolean :activated,   default: false
      t.integer :role, default: 30

      t.timestamps
    end
  end
end
