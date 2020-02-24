require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'display users' do
    before :each do
      user = create(:user, id: 1)
      create_list(:user, 20)
      5.times do
        count = User.count - 1
        user_1 = User.offset(rand(0..count)).limit(1).first
        user_2 = User.offset(rand(0..count)).limit(1).first

        create(:pairing, pairer_id: user.id, pairee_id: user_1.id)
        create(:pairing, pairer_id: user_1.id, pairee_id: user_2.id)
        create(:pairing, pairer_id: user_2.id, pairee_id: user_1.id)
      end
    end
    it 'can find user stats' do
      result = PairedBeSchema.execute(query).as_json
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
end
