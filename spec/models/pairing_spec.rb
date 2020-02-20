require 'rails_helper'

RSpec.describe Pairing, type: :model do
  describe 'relationships' do
    it { should belong_to :pairee }
    it { should belong_to :pairer }
  end
end
