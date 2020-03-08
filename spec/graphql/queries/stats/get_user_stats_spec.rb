require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'display users' do
    before :each do
      @user = create(:user, id: 1, name: 'Susie Q')
      user_1 = create(:user)
      user_2 = create(:user)
      user_3 = create(:user)

      create(:pairing, pairer_id: @user.id, pairee_id: user_1.id)
      create(:pairing, pairer_id: @user.id, pairee_id: user_1.id)
      create(:pairing, pairer_id: @user.id, pairee_id: user_2.id)
      create(:pairing, pairer_id: @user.id, pairee_id: user_3.id)
      create(:pairing, pairer_id: @user.id, pairee_id: user_3.id)
      x = create(:pairing, pairer_id: @user.id, pairee_id: nil)
    end
    it 'can find user stats' do
      result = PairedBeSchema.execute(query).as_json

      expect(result["data"]["getUserStats"]["name"]).to eq("Susie Q")
      expect(result["data"]["getUserStats"]["totalBookings"]).to eq(5)
      expect(result["data"]["getUserStats"]["totalMentorHours"]).to eq(2.5)
      expect(result["data"]["getUserStats"]["totalHoursMentored"]).to eq(0)
      expect(result["data"]["getUserStats"]["mentees"].count).to eq(3)
    end

    it 'can have a mentee that is no longer in the system' do
      user_4 = create(:user, id: 343)

      create(:pairing, pairer_id: @user.id, pairee_id: 343)
      result = PairedBeSchema.execute(query).as_json
      expect(result["data"]["getUserStats"]["mentees"].count).to eq(4)

      #the query_2 deletes a pairee user 
      PairedBeSchema.execute(query_2).as_json
      result = PairedBeSchema.execute(query).as_json

      expect(result["data"]["getUserStats"]["totalMentorHours"]).to eq(3)
      expect(result["data"]["getUserStats"]["mentees"].count).to eq(3)
    end
  end

  def query
    <<~GQL
    {
      getUserStats(id: "1") {
        name
        totalBookings
        totalMentorHours
        totalHoursMentored
        mentees {
          name }
        }
    }
    GQL
  end
  def query_2
    <<~GQL
    mutation {
      deleteUser(
        input:{
          id: "343" } ) {
        name
      }
    }
    GQL
  end
end
