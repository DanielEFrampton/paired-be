desc 'Send reminders for all morning pairings'
task :morning_reminders => :environment do
  Pairing.send_reminders('morning')
  puts 'done'
end

desc 'Send reminders for all afternoon pairings'
task :afternoon_reminders => :environment do
  Pairing.send_reminders('lunch')
  Pairing.send_reminders('afternoon')
  puts 'done'
end
