class User < ApplicationRecord
  validates_presence_of :name, :mod, :program, :pronouns,
                        :slack, :email, :image, :phone_number, :firebase_id


  validates :phone_number, length: {is: 10}

  has_many :skills, dependent: :destroy
  has_many :interests, dependent: :destroy

  has_many :paired_users, foreign_key: :pairer_id, class_name: 'Pairing'
  has_many :pairees, through: :paired_users

  has_many :pairing_users, foreign_key: :pairee_id, class_name: 'Pairing'
  has_many :pairers, through: :pairing_users

  def total_mentor_bookings(object)
    Pairing.where('pairer_id = ? AND pairee_id IS NOT NULL', object.id).count
  end

  def user_total_mentor_hours(object)
    (total_mentor_bookings(object) * 30.0) / 60.0
  end

  def user_total_hours_mentored(object)
    pairee_count = Pairing.where('pairee_id = ?', object.id).count
    (pairee_count * 30.0) / 60.0
  end

  def unique_mentees(obect)
    object.pairees.uniq
  end
end
