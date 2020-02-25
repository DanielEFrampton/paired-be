require 'rails_helper'

RSpec.describe 'delete pairing', type: :request do
  describe 'resolve' do
    before :each do
      @pairing = create :pairing
      @query = <<~GQL
                mutation {
                  pairing: deletePairing(
                    input: {
                      id: #{@pairing.id}
                    }
                  ){
                    pairer{id}
                    pairee{id}
                  }
                }
              GQL
      @pairee = @pairing.pairee
      @pairer = @pairing.pairer
    end

    it 'deletes the pairing' do
      expect(Pairing.count).to eq(1)
      post '/graphql', params: {query: @query}
      result = JSON.parse(response.body)['data']['pairing']
      expect(result['pairer']['id']).to eq(@pairer.id.to_s)
      expect(result['pairee']['id']).to eq(@pairee.id.to_s)
      expect(Pairing.count).to eq(0)
    end
  end
end
