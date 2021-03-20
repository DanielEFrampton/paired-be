class RockAndPebble < ApplicationRecord
    belongs_to :rock, class_name: 'User'
    belongs_to :pebble, class_name: 'User'

    def rock_pebble_info
      {rock_name: rock.name,
       pebble_name: pebble.name,
       pebble_email: pebble.email,
       rock_email: rock.email
      }
    end
end
