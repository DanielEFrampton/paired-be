class User < ApplicationRecord
  validates_presence_of :name, :mod, :program,
                        :slack, :email, :image, :firebase_id

  validates_numericality_of :mod, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 5

  has_many :skills, dependent: :destroy
  has_many :interests, dependent: :destroy

  has_many :paired_users, foreign_key: :pairer_id, class_name: 'Pairing'
  has_many :pairees, through: :paired_users

  has_many :pairing_users, foreign_key: :pairee_id, class_name: 'Pairing'
  has_many :pairers, through: :pairing_users

  has_many :rock_users, foreign_key: :pebble_id, class_name: 'RockAndPebble'
  has_many :rocks, through: :rock_users

  has_many :pebble_users, foreign_key: :rock_id, class_name: 'RockAndPebble'
  has_many :pebbles, through: :pebble_users

  def total_mentor_bookings
    Pairing.where('pairer_id = ? AND pairee_id IS NOT NULL', self.id).count
  end

  def user_total_mentor_hours
    (total_mentor_bookings * 30.0) / 60.0
  end

  def user_total_hours_mentored
    pairee_count = Pairing.where('pairee_id = ?', self.id).count
    (pairee_count * 30.0) / 60.0
  end

  def unique_mentees
    pairees.uniq
  end
end
