class Addnamerace < ActiveRecord::Migration[6.0]
	def change
		add_column :races, :name, :string
  end
end
