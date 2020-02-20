class AddNameToSkills < ActiveRecord::Migration[6.0]
  def change
    add_column :skills, :name, :string
  end
end
