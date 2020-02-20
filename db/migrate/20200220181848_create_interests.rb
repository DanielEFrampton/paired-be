class CreateInterests < ActiveRecord::Migration[6.0]
  def change
    create_table :interests do |t|

      t.timestamps
    end
  end
end
