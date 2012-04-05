class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.timestamps
    end

    create_table :teams_users do |t|
      t.integer :team_id
      t.integer :user_id
      t.timestamps
    end

    add_index :teams_users, :team_id
    add_index :teams_users, :user_id
    add_index :teams_users, [:team_id, :user_id], :unique => true
  end
end
