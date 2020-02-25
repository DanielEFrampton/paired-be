class RemoveModFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :mod, :string
    add_column :users, :mod, :integer
  end
end
