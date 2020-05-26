class AddOptInToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :rock_opt_in, :boolean, :default => false
  end
end
