require 'rails_helper'

RSpec.describe 'CreatePairings', type: :request do
  describe '.resolve' do
    before :each do
      @user = (create :user, id: '22')
      @query = <<~GQL
              mutation {
                createPairings(input: {
                              pairings: [{date:"Mon Apr 29 2019", time:"morning", pairer:"22"},{date:"Mon May 06 2019", time:"morning", pairer:"22"}]
                              }) {
                                unbookedPairings {
                                  pairer { id }
                                  date
                                  time
                                }
                              }
                            }
              GQL
    end

    it 'creates pairings' do
      expect(Pairing.count).to eq(0)
      post '/graphql', params: {query: @query}
      expect(Pairing.count).to eq(2)
    end

    it 'returns pairings' do
      post '/graphql', params: { query: @query }
      json = JSON.parse(response.body)
      data = json['data']['createPairings']['unbookedPairings']

      expect(data[0]['date']).to eq("Mon Apr 29 2019")
      expect(data[0]['time']).to eq("morning")
    end
  end

end
