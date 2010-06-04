title "Phamous Algemeen"

panel do
  # Datum: dd/mm/yyyy
  #
  # Naam beoordelaar: [string]
  question :q02, :type => :string do
    title "Naam beoordelaar"
  end
  
  # Reden voor screening:
  # ( ) Jaarlijkse screening
  # ( ) Ander interval, screening na [string___________],
  #                           reden: [string___________]
  question :q03, :type => :radio do
    title "Reden voor screening"
    option :q03a01, :description => "Jaarlijkse screening"
    option :q03a02, :description => "Ander interval" do
      question :q03a02q01, :type => :string, :title => "Screening na"
      question :q03a02q02, :type => :string, :title => "reden"
    end
  end
  
  
  # Etniciteit:
  # ( ) Caucasisch (blank)               ( ) Turks
  # ( ) Negroide                         ( ) Marokkaans
  # ( ) Aziatisch                        ( ) Anders, namelijk [string___________]
  # ( ) Indiaans / Latijns-Amerikaans
  question :q04, :type => :radio do
    title "Etniciteit"
    option :q04a01, :description => "Caucasisch (blank)"
    option :q04a02, :description => "Negro&iuml;de"
    option :q04a03, :description => "Aziatisch"
    option :q04a04, :description => "Indiaans / Latijns-Amerikaans"
    option :q04a05, :description => "Turks"
    option :q04a06, :description => "Marokkaans"
    option :q04a07, :description => "Anders" do
      question :q04a07q01, :type => :string, :title => "namelijk"
    end
  end
    
end
