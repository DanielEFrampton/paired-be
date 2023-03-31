module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :module,
          String,
          null: false,
          method: :mod,
          method_conflict_warning: false
    field :program, String, null: false
    field :pronouns, String, null: true
    field :slack, String, null: false
    field :email, String, null: false
    field :image, String, null: false
    field :phone_number, String, null: true
    field :firebase_i_d, String, null: false
    field :rock_opt_in, Boolean, null: false

    field :skills, [String], null: true

    field :total_bookings, Integer, null: true
    field :total_mentor_hours, Float, null: true
    field :total_hours_mentored, Float, null: true
    field :mentees, [Types::UserType], null: true

    field :rocks, [Types::UserType], null: true
    field :pebbles, [Types::UserType], null: true
    field :my_rocks, [Types::UserType], null: true
    field :my_pebbles, [Types::UserType], null: true
    field :pending_pebbles, [Types::UserType], null: true
    field :pending_rocks, [Types::UserType], null: true

    def skills
      object.skills.map { |skill| skill.name }
    end

    def total_bookings
      object.total_mentor_bookings
    end

    def total_mentor_hours
      object.user_total_mentor_hours
    end

    def total_hours_mentored
      object.user_total_hours_mentored
    end

    def mentees
      object.unique_mentees
    end

    def my_rocks
      object.active_rocks
    end

    def my_pebbles
      object.active_pebbles
    end

    def pending_pebbles
      object.pending_pebbles
    end

    def pending_rocks
      object.pending_rocks
    end
  end
end
