class CreateDrivers < ActiveRecord::Migration[6.0]
  def change
    create_table :drivers do |t|
			t.string :name
			t.integer :age
			t.integer :num_races
			t.integer :current_team
      t.timestamps
    end
  end
end
