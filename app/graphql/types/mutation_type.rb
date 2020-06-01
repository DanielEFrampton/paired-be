module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::Users::CreateUser
    field :create_pairings, mutation: Mutations::Pairings::CreatePairings
    field :delete_pairing, mutation: Mutations::Pairings::DeletePairing

    field :cancel_mentor_pairing, mutation: Mutations::Pairings::CancelMentorPairing
    field :cancel_mentee_pairing, mutation: Mutations::Pairings::CancelMenteePairing

    field :update_user, mutation: Mutations::Users::UpdateUser
    field :update_user_optin_status, mutation: Mutations::Users::UpdateUserOptinStatus
    field :update_pairing, mutation: Mutations::Pairings::UpdatePairing
    field :delete_pairings, mutation: Mutations::Pairings::DeleteUserPairings
    field :delete_user, mutation: Mutations::Users::DeleteUser

    field :decline_rock_pebble_relationship, mutation: Mutations::RockAndPebbles::DeclineRockPebbleRelationship
    field :create_rock_pebble_relationship, mutation: Mutations::RockAndPebbles::CreateRockPebbleRelationship
  end
end
