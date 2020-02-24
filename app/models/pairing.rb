class Pairing < ApplicationRecord
  belongs_to :pairer, class_name: 'User'
  belongs_to :pairee, class_name: 'User', optional: true
end
