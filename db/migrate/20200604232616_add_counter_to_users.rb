class AddCounterToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :pebbles_count, :integer, default: 0
  end
end
