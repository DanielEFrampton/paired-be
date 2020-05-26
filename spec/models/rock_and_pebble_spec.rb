require 'rails_helper'
RSpec.describe RockAndPebble, type: :model do
    describe 'relationships' do
        it { should belong_to :rock }
        it { should belong_to :pebble }
    end
end