class Addurl < ActiveRecord::Migration[6.0]
	def change
		add_column :races, :url, :string
		add_column :circuits, :url, :string
		add_column :results, :url, :string
		add_column :drivers, :url, :string
		add_column :engines, :url, :string

  end
end
