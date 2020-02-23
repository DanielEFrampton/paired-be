require 'rails_helper'

RSpec.describe 'CreatePairings', type: :request do
  describe '.resolve' do
    before :each do
      @users = create_list :user, 2
      @query = <<~GQL
            mutation {
                pairing: createPairings(
                  input: {
                    date: "October 22",
                    pairerId: #{@users[0].id},
                    paireeId: #{@users[1].id},
                    time: "4:00"
                  }
                  ) {
                      date
                      pairer {name}
                      time
                    }

                  }
              GQL
    end

    it 'creates a pairing' do
      expect(Pairing.count).to eq(0)
      post '/graphql', params: {query: @query}
      expect(Pairing.count).to eq(1)
    end

    it 'returns a pairing' do
      post '/graphql', params: { query: @query }
      json = JSON.parse(response.body)
      data = json['data']

      expect(data['pairing']['date']).to eq(Pairing.last.date)
      expect(data['pairing']['time']).to eq(Pairing.last.time)
      expect(data['pairing']['pairer']['name']).to eq(@users[0].name)
    end
  end

end
