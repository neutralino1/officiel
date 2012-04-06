class PolymorphicPermissions < ActiveRecord::Migration
  def change
    remove_column :permissions, :user_id
    add_column :permissions, :entity_id, :integer
    add_column :permissions, :entity_type, :string
    add_index :permissions, [:entity_id, :entity_type]
    add_index :permissions, [:entity_id, :entity_type, :page_id], :unique => true
  end

end
