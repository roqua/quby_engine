title "Phamous Algemeen"

"foo"

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
    other  :q04a07, :description => "Anders, namelijk"
  end
    
end
