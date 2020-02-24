module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::Users::CreateUser
    field :delete_pairings, mutation: Mutations::Pairings::DeleteUserPairings
    field :delete_user, mutation: Mutations::Users::DeleteUser
  end
end
