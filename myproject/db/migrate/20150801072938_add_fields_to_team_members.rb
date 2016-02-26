class AddFieldsToTeamMembers < ActiveRecord::Migration
  def change
  	add_column :team_members, :twitter_link, :string
    add_column :team_members, :facebook_link, :string
    add_column :team_members, :linkedin_link, :string
  end
end
