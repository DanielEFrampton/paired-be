class RemoveCountFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :pebbles_count, :integer
  end
end
