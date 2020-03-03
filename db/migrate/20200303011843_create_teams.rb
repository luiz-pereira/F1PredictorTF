class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
			t.string :name
			t.integer :current_engine
			t.integer :num_races
			t.decimal :budget
      t.timestamps
    end
  end
end
