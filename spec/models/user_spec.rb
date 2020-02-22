require 'rails_helper'

RSpec.describe User, type: :model do
   describe 'validations' do
      it { should validate_presence_of :name }
      it { should validate_presence_of :mod }
      it { should validate_presence_of :program }
      it { should validate_presence_of :slack }
      it { should validate_presence_of :firebase_id }
      it { should validate_presence_of :email }
      it { should validate_presence_of :phone_number }
      it { should validate_length_of(:phone_number).is_equal_to(10) }
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
