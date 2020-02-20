class AddLimitToUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :phone_number, :string, limit: 10
  end
end
