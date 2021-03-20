class AddPending < ActiveRecord::Migration[6.0]
  def change
    add_column :rock_and_pebbles, :pending, :boolean, :default => false
  end
end
