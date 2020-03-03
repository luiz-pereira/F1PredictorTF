class CreateDriverRaces < ActiveRecord::Migration[6.0]
  def change
    create_table :driver_races do |t|
			t.integer :driver_id
			t.integer :race_id
			t.integer :position_start
			t.integer :position_finish
			t.time :best_lap
			t.time :total_time
			t.integer :team_id
			t.integer :engine_id
      t.timestamps
    end
  end
end
