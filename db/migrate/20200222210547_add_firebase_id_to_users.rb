class AddFirebaseIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :firebase_id, :string
  end
end
