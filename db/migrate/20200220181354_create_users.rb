class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :module
      t.string :program
      t.string :pronouns
      t.string :slack
      t.string :email
      t.string :image
      t.string :phone_number

      t.timestamps
    end
  end
end
