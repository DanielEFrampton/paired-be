class RemoveModuleFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :module, :string
    add_column :users, :mod, :string
  end
end
