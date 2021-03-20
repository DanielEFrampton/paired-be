class CreateOutgoingEmailCommunications < ActiveRecord::Migration[6.0]
  def change
    create_table :outgoing_email_communications do |t|
      t.references :user, null: false, foreign_key: true
      t.string :response_body
      t.string :response_status
      t.string :message_type
      t.timestamps
    end
  end
end
