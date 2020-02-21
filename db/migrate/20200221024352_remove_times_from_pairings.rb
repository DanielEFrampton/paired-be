class RemoveTimesFromPairings < ActiveRecord::Migration[6.0]
  def change
    remove_column :pairings, :times, :string
    add_column :pairings, :time, :string
  end
end
