class Asd < ActiveRecord::Migration[6.0]
	def change
		change_column :results, :position_start, :string
		change_column :results, :position_finish, :string
  end
end
