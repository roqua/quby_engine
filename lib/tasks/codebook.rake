# frozen_string_literal: true

namespace :codebook do

  desc "Export all questionnaire codebooks to tmp/codebooks/$key.txt"
  task :export => :environment do
    system("mkdir -p #{Rails.root}/tmp/codebooks")
    
    Questionnaire.all.each do |questionnaire|
      File.open("#{Rails.root}/tmp/codebooks/#{questionnaire.key}.txt", "w") do |file|
        file.puts(questionnaire.to_codebook)
      end
    end
  end

end
