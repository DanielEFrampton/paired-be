# Import JSON data exported from old BE's MongoDB from command line.
# Usage: `rake import users.json pairings.json` if files are in root dir.

desc "Import data from json files"
task :import => [:environment] do

  Skill.destroy_all
  Pairing.destroy_all
  User.destroy_all

  # If you need to add oid to the user table use the following line.
  # Does not work consistently; might need to run task once with below
  # uncommented, then run again with line commented.
  # ActiveRecord::Migration.add_column :users, :oid, :string

  File.open(ARGV[1]).each do |line|
    user_data = JSON.parse(line)
       User.create(oid: user_data["_id"]["$oid"],
                   name: user_data["name"],
                   mod: user_data["module"]["$numberInt"].to_i,
                   program: user_data["program"],
                   pronouns: user_data["pronouns"],
                   slack: user_data["slack"],
                   email: user_data["email"],
                   image: user_data["image"],
                   firebase_id: user_data["firebaseID"]
                )

    user = User.last

    user_data["skills"].each do |skill|
      user.skills.create(name: skill)
    end
  end

  File.open(ARGV[2]).each do |line|
    pairing_data = JSON.parse(line)
      if User.where(oid: pairing_data["pairer"]["$oid"]).empty?
        pairer_id = nil
      else
        pairer_id = User.where(oid: pairing_data["pairer"]["$oid"]).first.id
      end

      if pairing_data["pairee"].nil?
        pairee_id = nil
      elsif  User.where(oid: pairing_data["pairee"]["$oid"]).empty?
        pairee_id = nil
      else
        pairee_id = User.where(oid: pairing_data["pairee"]["$oid"]).first.id
      end
    Pairing.create( pairer_id: pairer_id,
                    pairee_id: pairee_id,
                    date: pairing_data["date"],
                    time: pairing_data["time"],
                    notes: pairing_data["notes"]
                   )
  end

  # Associated migration to remove oid from users table
  ActiveRecord::Migration.remove_column :users, :oid, :string
end
