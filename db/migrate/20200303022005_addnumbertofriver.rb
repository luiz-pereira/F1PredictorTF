class Addnumbertofriver < ActiveRecord::Migration[6.0]
	def change
		add_column :drivers, :number, :integer
		add_column :drivers, :races, :integer
		add_column :drivers, :poles, :integer
		add_column :drivers, :wins, :integer
		add_column :drivers, :podiums, :integer
		add_column :drivers, :fastest_laps, :integer
		add_column :drivers, :championships, :integer
  end
end
