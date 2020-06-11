class OutgoingEmailCommunication < ApplicationRecord
  belongs_to :user
  enum message_type: [ :appt_initial_message,
                       :appt_reminder_message,
                       :appt_cancel_message,
                       :rp_confirmation_message,
                       :rp_acceptance_message,
                       :rp_denial_message,
                       :pebble_discontinuation_message,
                       :rock_discontinuation_message
                     ]
end
