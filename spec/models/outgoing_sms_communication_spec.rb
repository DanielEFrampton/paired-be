require 'rails_helper'

RSpec.describe OutgoingSmsCommunication, type: :model do
  describe 'relationships' do
    it {should belong_to :user}
  end

  describe 'methods' do
    it 'self.create' do
      user = create :user
      status = 'success'
      msg_type = :initial_message

      OutgoingSmsCommunication.create(user.email, status, msg_type)

      test_obj = OutgoingSmsCommunication.last
      expect(test_obj.user).to eq(user)
      expect(test_obj.status).to eq(status)
      expect(test_obj.message_type).to eq(msg_type.to_s)
    end
  end
end
