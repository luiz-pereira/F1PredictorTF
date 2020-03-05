class Addnameraceaba < ActiveRecord::Migration[6.0]
	def change
		remove_column :races, :race_date
  end
end
