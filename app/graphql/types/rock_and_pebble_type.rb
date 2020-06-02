module Types
  class RockAndPebbleType < Types::BaseObject
      field :id, ID, null: false
      field :rock, Types::UserType, null: true
      field :pebble, Types::UserType, null: true
      field :active, Boolean, null: false
      field :my_rocks, [Types::UserType], null: true
      field :my_pebbles, [Types::UserType], null: true

    def my_rocks
      user = User.find(object.pebble_id)
      user.rocks
    end

    def my_pebbles
      user = User.find(object.rock_id)
      user.pebbles
    end
  end
end
