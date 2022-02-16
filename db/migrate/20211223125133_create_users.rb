class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :search_name, null: false 

      t.index :search_name, unique: true
      t.timestamps
    end
  end
end