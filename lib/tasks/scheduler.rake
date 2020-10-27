task :update_player => :environment do
  puts "Updating player..."
  Player.new.do_it
  puts "done."
end