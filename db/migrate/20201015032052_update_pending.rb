class UpdatePending < ActiveRecord::Migration[6.0]
  def change
    change_column :rock_and_pebbles, :pending, :boolean, :default => true
  end
end
