class Changecurrentteam < ActiveRecord::Migration[6.0]
	def change
		rename_column :drivers, :current_team, :current_team_id
  end
end
