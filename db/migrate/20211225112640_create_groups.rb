class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :overview
      t.boolean :personal

      t.timestamps
    end
  end
end
