class RenameSmsType < ActiveRecord::Migration[6.0]
  def change
    rename_column :outgoing_sms_communications, :type, :message_type
  end
end
