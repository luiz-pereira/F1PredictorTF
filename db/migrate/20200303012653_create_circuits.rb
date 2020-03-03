class CreateCircuits < ActiveRecord::Migration[6.0]
  def change
    create_table :circuits do |t|
			t.string :name
			t.string :country
			t.string :continent
			t.integer :num_races
      t.timestamps
    end
  end
end
