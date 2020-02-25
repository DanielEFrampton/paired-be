module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :mod, String, null: false
    field :program, String, null: false
    field :pronouns, String, null: false
    field :slack, String, null: false
    field :email, String, null: false
    field :image, String, null: false
    field :phone_number, String, null: false
    field :firebase_id, String, null: false

    field :skills, [String], null: true

    field :total_bookings, Integer, null: true
    field :total_mentor_hours, Float, null: true
    field :total_hours_mentored, Float, null: true
    field :mentees, [Types::UserType], null: true

    def skills
      object.skills.map do |skill|
        skill.name
      end
    end

    def total_bookings
      Pairing.where('pairer_id = ? AND pairee_id IS NOT NULL', object.id).count
    end

    def total_mentor_hours
      (total_bookings * 30.0) / 60.0
    end

    def total_hours_mentored
      pairee_count = Pairing.where('pairee_id = ?', object.id).count
      (pairee_count * 30.0) / 60.0
    end

    def mentees
      object.pairees.uniq
    end
  end
end
