namespace :questionnaires do

  desc "Create/update questionnaires if their counterpart in app/questionnaires/*.rb is newer than the db record."
  task :update => :environment do
    files = Dir[Rails.root.join("db", "questionnaires", "*.rb")]
    
    files.each do |path|
      print "Checking #{path}... "
      key = File.basename(path, ".rb")
      questionnaire = Questionnaire.find_by_key(key)
      
      begin
        
        if questionnaire
          puts "Found in DB."
        else
          puts "Not found in DB, adding."
          questionnaire = Questionnaire.new(:key => key,
                                            :definition => File.read(path))
          questionnaire.save
        end
        
      rescue
        puts "  Exception occurred. Skipping #{path}."
      end
    end
  end

end
