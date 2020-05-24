class CreateRockAndPebbles < ActiveRecord::Migration[6.0]
  def change
    create_table :rock_and_pebbles do |t|
      t.integer :rock_id
      t.integer :pebble_id
      t.boolean :active, default: false
      t.timestamps
    end
  end
end
