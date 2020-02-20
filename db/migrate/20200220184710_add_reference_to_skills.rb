class AddReferenceToSkills < ActiveRecord::Migration[6.0]
  def change
    add_reference :skills, :user, null: false, foreign_key: true
  end
end
