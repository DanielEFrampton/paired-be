module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::Users::CreateUser
    field :update_user, mutation: Mutations::Users::UpdateUser
    field :update_pairing, mutation: Mutations::Pairings::UpdatePairing
    field :delete_pairings, mutation: Mutations::Pairings::DeleteUserPairings
    field :delete_user, mutation: Mutations::Users::DeleteUser
  end
end
