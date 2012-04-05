class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.string :title
      t.text :content
      t.integer :version
      t.integer :page_id
      t.timestamps
    end
    add_index :versions, :page_id
  end
end
