class Changeteams < ActiveRecord::Migration[6.0]
	def change
		add_column :teams, :url, :string
		remove_column :drivers, :races
  end
end
