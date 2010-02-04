namespace :questionnaires do

  desc "Create/update questionnaires if their counterpart in app/questionnaires/*.rb is newer than the db record."
  task :update => :environment do
    files = Dir[File.join(RAILS_ROOT, "app", "questionnaires", "*.rb")]
    
    files.each do |path|
      puts "Checking #{path}"
      key = File.basename(path, ".rb")
      questionnaire = Questionnaire.find_by_key(key)
      
      begin
        
        if questionnaire
          if File.ctime(path) > questionnaire.updated_at
            puts "  File on disk is more recent. Loading from disk."
            questionnaire.definition = File.read(path)
            questionnaire.save
          else
            puts "  Database record is up to date. Skipping."
          end
        else
          puts "  File on disk, but no database record found. Adding."
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
