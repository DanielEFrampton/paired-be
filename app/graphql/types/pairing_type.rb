module Types
  class PairingType < Types::BaseObject
    field :id, ID, null: false
    field :pairer, Types::UserType, null: true
    field :pairee, Types::UserType, null: true
    field :date, String, null: false
    field :time, String, null: false
    field :notes, String, null: true
    field :unbooked_pairings, [Types::PairingType], null: true

    def pairer
      return if object.class == Array || object.pairer_id.nil?
      User.find(object.pairer_id)
    end

    def pairee
      return if object.class == Array || object.pairee_id.nil?
      User.find(object.pairee_id)
    end

    def unbooked_pairings
      object.paired_users.where(pairee: nil)
    end
  end
end
