class Changejontablename < ActiveRecord::Migration[6.0]
	def change
		rename_table :driver_races, :results
  end
end
