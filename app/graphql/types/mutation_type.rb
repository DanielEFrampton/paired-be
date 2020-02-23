module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::Users::CreateUser
    field :create_pairing, mutation: Mutations::Pairings::CreatePairing
  end
end
