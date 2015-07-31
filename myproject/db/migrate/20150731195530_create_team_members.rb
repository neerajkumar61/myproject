class CreateTeamMembers < ActiveRecord::Migration
  def change
    create_table :team_members do |t|
      t.string :name
      t.string :image
      t.string :designation

      t.timestamps null: false
    end
  end
end
