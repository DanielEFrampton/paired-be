module Types
  class RockAndPebbleType < Types::BaseObject
      field :id, ID, null: false
      field :rock, Types::UserType, null: true
      field :pebble, Types::UserType, null: true
      field :active, Boolean, null: false
      field :my_rocks, [Types::UserType], null: true
      field :my_pebbles, [Types::UserType], null: true
  end
end
