class User < ApplicationRecord
  validates_presence_of :name, :mod, :program, :phone_number, :email,
                        :slack, :firebase_id

  validates :phone_number, length: {is: 10}

  has_many :skills, dependent: :destroy
  has_many :interests, dependent: :destroy

  has_many :paired_users, foreign_key: :pairer_id, class_name: 'Pairing'
  has_many :pairees, through: :paired_users

  has_many :pairing_users, foreign_key: :pairee_id, class_name: 'Pairing'
  has_many :pairers, through: :pairing_users
end
