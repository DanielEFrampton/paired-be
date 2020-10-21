# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
include FactoryBot::Syntax::Methods

User.destroy_all
Interest.destroy_all
Skill.destroy_all
Pairing.destroy_all
RockAndPebble.destroy_all

30.times do
  new_user = create(:user_random_opt_in)
  rand(1..3).times do
    create(:skill, user: new_user )
  end
  rand(1..3).times do
    create(:pairing, pairer: new_user, pairee: nil)
  end
end

15.times do
  count = User.count - 1
  user_1 = User.offset(rand(0..count)).limit(1).first
  user_2 = User.offset(rand(0..count)).limit(1).first

  create(:pairing, pairer_id: user_1.id, pairee_id: user_2.id)
  create(:pairing, pairer_id: user_2.id, pairee_id: user_1.id)
 end

15.times do
  count = User.count - 1
  user_1 = User.offset(rand(0..count)).limit(1).first
  user_2 = User.offset(rand(0..count)).limit(1).first

  create(:rock_and_pebble, rock: user_1, pebble: user_2)
end

# Test user integrated into seed data for faster manual integration testing.
# There is a real Github account associated with this address with a real Firebase ID.
# Firebase ID is associated with the staging area Firebase account, won't work in production repo.
test_user = create(:user, email: 'landslideappteam@gmail.com', firebase_id: 'STgm6VyJm9eGV2ZgARQ2j5lusWG3')
create_list(:skill_from_dropdown, 2, user: test_user)
create(:skill, user: test_user)
all_users = User.where.not(id: test_user.id) # for sampling below
# for View Schedule
3.times { create(:pairing_with_notes, pairer: test_user, pairee: all_users.sample) } # Giving Help
3.times { create(:pairing_with_notes, pairer: all_users.sample, pairee: test_user) } # Receiving Help
create_list(:pairing, 10, pairer: test_user, pairee: nil) # Open to Pair
# for testing stats pages
5.times { create(:past_pairing, pairee: all_users.sample, pairer: test_user) }
5.times { create(:past_pairing, pairer: all_users.sample, pairee: test_user) }
# for testing user's pebbles
create(:rock_and_pebble, rock: test_user, pebble: all_users.sample, active: false, pending: false)
create(:rock_and_pebble, rock: test_user, pebble: all_users.sample, active: false, pending: true)
create(:rock_and_pebble, rock: test_user, pebble: all_users.sample, active: true, pending: false)
# for testing user's rocks
create(:rock_and_pebble, rock: all_users.sample, pebble: test_user, active: true, pending: false)
create(:rock_and_pebble, rock: all_users.sample, pebble: test_user, active: false, pending: false)
