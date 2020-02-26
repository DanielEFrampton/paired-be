class AddModToUsers < ActiveRecord::Migration[6.0]
  def change
    def change
      add_column :users, :mod, :integer
    end
  end
end
