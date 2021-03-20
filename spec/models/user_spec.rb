require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
      it { should validate_presence_of :name }
      it { should validate_presence_of :mod }
      it { should validate_presence_of :program }
      it { should validate_presence_of :slack }
      it { should validate_presence_of :firebase_id }
      it { should validate_presence_of :email }
      it { should validate_numericality_of(:mod).is_greater_than_or_equal_to(1) }
      it { should validate_numericality_of(:mod).is_less_than_or_equal_to(5) }
    end

  describe 'relationships' do
      it { should have_many :interests }
      it { should have_many :skills }
      it { should have_many :paired_users }
      it { should have_many(:pairees).through(:paired_users) }
      it { should have_many :pairing_users }
      it { should have_many(:pairers).through(:pairing_users) }
      it { should have_many :rock_roles }
      it { should have_many :pebble_roles }
      it { should have_many :outgoing_sms_communications }
      it { should have_many :outgoing_email_communications }
      it { should have_many(:pebbles).through(:pebble_roles)}
      it { should have_many(:rocks).through(:rock_roles)}
    end

    describe 'methods' do
      before :each do 
        @user_1 = create :user
        @user_2 = create :user 
        @user_3 = create :user 
        @user_4 = create :user 
        @user_5 = create :user 
        @user_4.pebbles << @user_1
        @user_5.pebbles << @user_1
        @user_1.pebbles << [@user_2, @user_3]
  
        RockAndPebble.all[3].update(active: true)
        RockAndPebble.all[0].update(active: true)
        @rock_and_pebble = RockAndPebble.last
      end 
      it 'should return active pebbles and rocks' do
        expect(@user_1.active_pebbles).to eq([@user_3])
        expect(@user_1.active_rocks).to eq([@user_4])
      end 
    end 
end
