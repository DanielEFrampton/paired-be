module Types
  class RockAndPebbleType < Types::BaseObject
      field :id, ID, null: false
      field :rock, Types::UserType, null: true
      field :pebble, Types::UserType, null: true
      field :active, Boolean, null: false
  end
end
