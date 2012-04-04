class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.integer :user_id
      t.integer :page_id
      t.string :rights, :null => false, :default => 'read'
      t.timestamps
    end
    add_index :permissions, :user_id
    add_index :permissions, :page_id
    add_index :permissions, [:user_id, :page_id], :unique => true
    
    add_column :pages, :owner_id, :integer
    add_index :pages, :owner_id
  end
end
