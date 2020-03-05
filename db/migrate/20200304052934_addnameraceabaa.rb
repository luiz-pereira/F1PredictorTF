class Addnameraceabaa < ActiveRecord::Migration[6.0]
	def change
		add_column :races, :race_date, :string
  end
end
