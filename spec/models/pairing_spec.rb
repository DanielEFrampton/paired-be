require 'rails_helper'

RSpec.describe Pairing, type: :model do
  describe 'relationships' do
    it { should belong_to :pairer }
    it { should belong_to(:pairee).optional }
  end

  describe 'instance_methods' do
    before :each do
      @pairing = create :pairing
    end

    it 'pairer_email' do
      expect(@pairing.pairer_email).to eq(@pairing.pairer.email)
    end

    it 'pairee_email' do
      expect(@pairing.pairee_email).to eq(@pairing.pairee.email)
    end

    it 'pairer_name' do
      expect(@pairing.pairer_name).to eq(@pairing.pairer.name)
    end

    it 'pairee_name' do
      expect(@pairing.pairee_name).to eq(@pairing.pairee.name)
    end

    it 'pairer_phone_number' do
      expect(@pairing.pairer_phone_number).to eq(@pairing.pairer.phone_number)
    end

    it 'pairee_phone_number' do
      expect(@pairing.pairee_phone_number).to eq(@pairing.pairee.phone_number)
    end

    it 'pairer_contact_info' do
      expect(@pairing.pairer_contact_info).to eq({phone_number: @pairing.pairer.phone_number, email_address: @pairing.pairer.email})
    end

    it 'pairee_contact_info' do
      expect(@pairing.pairee_contact_info).to eq({phone_number: @pairing.pairee.phone_number, email_address: @pairing.pairee.email})
    end
  end
end
