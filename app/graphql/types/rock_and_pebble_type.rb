module Types
    class RockAndPebbleType < Types::BaseObject
        field :id, ID, null: false
        field :rock, Types::UserType, null: false
        field :pebble, Types::UserType, null: false
        field :active, Boolean, null: false
    end
end