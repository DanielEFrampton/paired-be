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

10.times do
  create(:user)
end

30.times do
  count = User.count - 1
  user = User.offset(rand(0..count)).limit(1).first
  create(:skill, user: user )
end

5.times do

  count = User.count - 1
  user_1 = User.offset(rand(0..count)).limit(1).first
  user_2 = User.offset(rand(0..count)).limit(1).first

  create(:pairing, pairer_id: user_1.id, pairee_id: user_2.id)
  create(:pairing, pairer_id: user_2.id, pairee_id: user_1.id)
 end
