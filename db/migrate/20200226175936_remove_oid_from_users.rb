class RemoveOidFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :oid, :string
  end
end
