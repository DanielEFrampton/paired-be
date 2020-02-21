module Types
  class PairingType < Types::BaseObject
    field :id, ID, null: false
    field :pairer_id, Integer, null: false
    field :pairee_id, Integer, null: false
    field :pairer, [Types::UserType], null: true
    field :pairee, [Types::UserType], null: true
    field :date, String, null: false
    field :time, String, null: false

    def pairer
      User.find(id: :pairer_id)
    end

    def pairee
      User.find(id: :pairee_id)
    end
  end
end
