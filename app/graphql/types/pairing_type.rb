module Types
  class PairingType < Types::BaseObject
    field :id, ID, null: false
    field :pairer, Types::UserType, null: false
    field :pairee, Types::UserType, null: false
    field :date, String, null: true
    field :time, String, null: true

    def pairer
      User.find(object.pairer_id)
    end

    def pairee
      User.find(object.pairee_id)
    end
  end
end
