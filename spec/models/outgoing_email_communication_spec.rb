require 'rails_helper'

RSpec.describe OutgoingEmailCommunication, type: :model do
  describe 'relationships' do
    it {should belong_to :user}
  end
end
