module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::Users::CreateUser
<<<<<<< HEAD
    field :create_pairings, mutation: Mutations::Pairings::CreatePairings
    field :delete_pairing, mutation: Mutations::Pairings::DeletePairing
=======
    field :update_user, mutation: Mutations::Users::UpdateUser
    field :delete_pairings, mutation: Mutations::Pairings::DeleteUserPairings
    field :delete_user, mutation: Mutations::Users::DeleteUser
>>>>>>> f920d361e2e8bcfd353ba0472ec14ea39db4f997
  end
end
