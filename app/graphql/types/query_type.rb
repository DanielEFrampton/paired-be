module Types
  class QueryType < Types::BaseObject
    field :get_users, [Types::UserType], null: false, description: 'Returns a list of users'
    field :get_user_stats, Types::UserType, null: false, description: 'Returns user stats' do
      argument :id, ID, required: true
    end
    field :get_pairings, [Types::PairingType], null: false, description: 'Returns all pairings'

    field :get_user, Types::UserType, null: false, description: 'Returns a single user by id' do
      argument :id, ID, required: true
    end

    field :get_user_by_firebase_i_d, Types::UserType, null: true, description: 'Returns a single user by firebase id' do
      argument :id, ID, required: true
    end

    field :get_user_pairings, [Types::PairingType], null: false, description: 'Returns a single user pairings by id' do
      argument :id, ID, required: true
    end

    field :get_pairing, Types::PairingType, null: false, description: 'Returns a single pairing by id' do
      argument :id, ID, required: true
    end

    field :get_available_pairings, resolver: Filters::AvailablePairings
    field :find_available_rocks, resolver: Filters::AvailableRocks

    field :get_user_rock_and_pebble, Types::UserType, null: false, description: 'Returns rock and pebble relationships by user' do
      argument :id, ID, required: true
    end

    def get_user_pairings(id:)
      Pairing.where('pairer_id = ? OR pairee_id = ?', id, id)
    end

    def get_users
      User.all
    end

    def get_user_stats(id:)
      User.find(id)
    end

    def get_user(id:)
      User.find(id)
    end

    def get_user_by_firebase_i_d(id:)
      User.where(firebase_id: id).first
    end

    def get_pairings
      Pairing.all
    end

    def get_pairing(id:)
      Pairing.find(id)
    end

    def get_user_rock_and_pebble(id:)
      User.find(id)
    end
  end
end
