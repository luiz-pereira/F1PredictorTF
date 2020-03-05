class Addnameraceab < ActiveRecord::Migration[6.0]
	def change
		change_column :races, :race_date, :string
  end
end
