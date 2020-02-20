class AddUsersToPairings < ActiveRecord::Migration[6.0]
  def change
    add_column :pairings, :pairer_id, :integer
    add_column :pairings, :pairee_id, :integer
  end
end
