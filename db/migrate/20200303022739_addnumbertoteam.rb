class Addnumbertoteam < ActiveRecord::Migration[6.0]
	def change
		add_column :teams, :races, :integer
		add_column :teams, :poles, :integer
		add_column :teams, :wins, :integer
		add_column :teams, :podiums, :integer
		add_column :teams, :fastest_laps, :integer
		add_column :teams, :driver_championships, :integer
		add_column :teams, :team_championships, :integer
  end
end
