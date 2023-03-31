class User < ApplicationRecord
  validates_presence_of :name,
                        :mod,
                        :program,
                        :slack,
                        :email,
                        :image,
                        :firebase_id

  validates_numericality_of :mod,
                            greater_than_or_equal_to: 1,
                            less_than_or_equal_to: 5

  has_many :skills, dependent: :destroy
  has_many :interests, dependent: :destroy

  has_many :paired_users, foreign_key: :pairer_id, class_name: "Pairing"
  has_many :pairees, through: :paired_users

  has_many :pairing_users, foreign_key: :pairee_id, class_name: "Pairing"
  has_many :pairers, through: :pairing_users

  has_many :rock_roles, foreign_key: :pebble_id, class_name: "RockAndPebble"
  has_many :rocks, through: :rock_roles

  has_many :pebble_roles, foreign_key: :rock_id, class_name: "RockAndPebble"
  has_many :pebbles, through: :pebble_roles

  has_many :outgoing_email_communications
  has_many :outgoing_sms_communications

  def total_mentor_bookings
    Pairing.where("pairer_id = ? AND pairee_id IS NOT NULL", self.id).count
  end

  def user_total_mentor_hours
    (total_mentor_bookings * 30.0) / 60.0
  end

  def user_total_hours_mentored
    pairee_count = Pairing.where("pairee_id = ?", self.id).count
    (pairee_count * 30.0) / 60.0
  end

  def unique_mentees
    pairees.uniq
  end

  def active_pebbles
    User.where(
      "users.id IN (SELECT rock_and_pebbles.pebble_id FROM users join rock_and_pebbles
         on rock_and_pebbles.rock_id = users.id WHERE rock_and_pebbles.active = true AND 
         rock_and_pebbles.rock_id = ?)",
      id,
    )
  end

  def active_rocks
    User.where(
      "users.id IN (SELECT rock_and_pebbles.rock_id FROM users join rock_and_pebbles
         on rock_and_pebbles.pebble_id = users.id WHERE rock_and_pebbles.active = true AND 
         rock_and_pebbles.pebble_id = ?)",
      id,
    )
  end

  def pending_pebbles
    User.where(
      "users.id IN (SELECT rock_and_pebbles.pebble_id FROM users join rock_and_pebbles
      on rock_and_pebbles.pebble_id = users.id WHERE rock_and_pebbles.pending = true AND 
      rock_and_pebbles.rock_id = ?)",
      id,
    )
  end

  def pending_rocks
    User.where(
      "users.id IN (SELECT rock_and_pebbles.rock_id FROM users join rock_and_pebbles
      on rock_and_pebbles.rock_id = users.id WHERE rock_and_pebbles.pending = true AND 
      rock_and_pebbles.pebble_id = ?)",
      id,
    )
  end
end
