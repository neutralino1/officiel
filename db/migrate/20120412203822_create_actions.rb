class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.integer :page_id, :null => false
      t.integer :user_id, :null => false
      t.string :action
      t.timestamps
    end
    add_index :actions, :page_id
    add_index :actions, :user_id
  end
end
