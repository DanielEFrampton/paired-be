desc 'Send reminders for all morning pairingd'
task :morning_reminders => :environment do
  Pairing.send_reminders('morning')
  puts 'done'
end
