class ChangeTypeToInteger < ActiveRecord::Migration[6.0]
  def change
    change_column :outgoing_email_communications, :message_type, :integer, using: 'message_type::integer'
  end
end
