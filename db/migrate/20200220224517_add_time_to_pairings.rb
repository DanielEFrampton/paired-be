class AddTimeToPairings < ActiveRecord::Migration[6.0]
  def change
    add_column :pairings, :times, :string
    add_column :pairings, :date, :string
    add_column :pairings, :notes, :string
  end
end
