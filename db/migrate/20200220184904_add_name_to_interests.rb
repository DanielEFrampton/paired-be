class AddNameToInterests < ActiveRecord::Migration[6.0]
  def change
    add_column :interests, :name, :string
    add_reference :interests, :user, null: false, foreign_key: true
  end
end
