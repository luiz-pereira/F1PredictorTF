class CreateRaces < ActiveRecord::Migration[6.0]
  def change
    create_table :races do |t|
			t.integer :circuit_id
			t.string :weather
			t.date :race_date
      t.timestamps
    end
  end
end
