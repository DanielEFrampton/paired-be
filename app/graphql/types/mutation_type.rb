module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::Users::CreateUser
    field :create_pairings, mutation: Mutations::Pairings::CreatePairings
    field :delete_pairing, mutation: Mutations::Pairings::DeletePairing
  end
end
