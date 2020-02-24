module Types
  class PairingType < Types::BaseObject
    field :id, ID, null: false
    field :pairer, Types::UserType, null: true
    field :pairee, Types::UserType, null: true
    field :date, String, null: true
    field :time, String, null: true
    field :notes, String, null: true

    def pairer
      return if object.class == Array
      User.find(object.pairer_id)
    end

    def pairee
      return if object.class == Array
      User.find(object.pairee_id)
    end
  end
end
