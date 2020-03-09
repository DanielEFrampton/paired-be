desc 'Send reminders for all morning pairingd'
task :morning_reminders => :environment do
  Pairing.send_reminders('morning')
  puts 'done'
end

task :afternoon_reminders => :environment do
  Pairing.send_reminders('lunch')
  Pairing.send_reminders('afternoon')
  puts 'done'
end
