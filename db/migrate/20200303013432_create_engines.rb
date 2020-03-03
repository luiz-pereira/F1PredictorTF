class CreateEngines < ActiveRecord::Migration[6.0]
  def change
    create_table :engines do |t|
			t.string :engine
      t.timestamps
    end
  end
end
