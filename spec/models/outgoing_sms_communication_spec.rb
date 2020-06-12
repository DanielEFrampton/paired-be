require 'rails_helper'

RSpec.describe OutgoingSmsCommunication, type: :model do
  describe 'relationships' do
    it {should belong_to :user}
  end

  describe 'methods' do
    it 'self.record' do
      user = create :user
      status = 'success'
      msg_type = :initial_message

      OutgoingSmsCommunication.record(user.email, status, msg_type)

      test_obj = OutgoingSmsCommunication.last
      expect(test_obj.user).to eq(user)
      expect(test_obj.status).to eq(status)
      expect(test_obj.message_type).to eq(msg_type.to_s)
    end

    it 'self.type_map' do
      type_map = OutgoingSmsCommunication.type_map
      expect(type_map[:initial_message]).to eq(0)
      expect(type_map[:cancellation_message]).to eq(1)
      expect(type_map[:reminder_message]).to eq(2)
    end
  end

end
