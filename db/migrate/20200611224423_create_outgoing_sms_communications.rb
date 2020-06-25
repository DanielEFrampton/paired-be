class CreateOutgoingSmsCommunications < ActiveRecord::Migration[6.0]
  def change
    create_table :outgoing_sms_communications do |t|
      t.references :user, null: false, foreign_key: true
      t.string :status
      t.integer :type

      t.timestamps
    end
  end
end
