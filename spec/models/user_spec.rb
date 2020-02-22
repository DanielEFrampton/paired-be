require 'rails_helper'

RSpec.describe User, type: :model do
   describe 'validations' do
      it { should validate_presence_of :name }
      it { should validate_presence_of :mod }
      it { should validate_presence_of :program }
    end

    describe 'relationships' do
      it { should have_many :interests }
      it { should have_many :skills }
      it { should have_many :paired_users }
      it { should have_many(:pairees).through(:paired_users) }
      it { should have_many :pairing_users }
      it { should have_many(:pairers).through(:pairing_users) }
    end
end
