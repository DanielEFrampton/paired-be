class RockAndPebble < ApplicationRecord
    belongs_to :rock, class_name: 'User'
    belongs_to :pebble, class_name: 'User'
end

