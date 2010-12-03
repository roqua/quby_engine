title "Phamous Algemeen"

panel do
  question :v_date, :day_key => :v_1063, :month_key => :v_1064, :year_key => :v_1065, :type => :date, :required => true do
    title "Datum"
    validates_format_with /\d?\d-\d?\d-\d\d\d\d/, :explanation => "Voldoet niet aan formaat DD - 1 of 2 cijfers, MM - 1 of 2 cijfers, JJJJ - 4 cijfers"
  end
  
  # Naam beoordelaar: [string]
  question :v_143, :type => :string, :required => true do
    title "Naam beoordelaar"
  end
  
  # Reden voor screening:
  # ( ) Jaarlijkse screening
  # ( ) Ander interval, screening na [string___________],
  #                           reden: [string___________]
  question :v_144, :type => :radio, :required => true do
    title "Reden voor screening"
    option :a01, :value => 1, :description => "Jaarlijkse screening"
    option :a02, :value => 2, :description => "Ander interval" do
      question :v_145, :type => :string, :title => "Screening na", :required => true
      question :v_146, :type => :string, :title => "reden", :required => true 
    end
  end
  
  # Etniciteit:
  # ( ) Caucasisch (blank)               ( ) Turks
  # ( ) Negroide                         ( ) Marokkaans
  # ( ) Aziatisch                        ( ) Anders, namelijk [string___________]
  # ( ) Indiaans / Latijns-Amerikaans
  question :v_178, :type => :radio, :required => true do
    title "Etniciteit"
    option :a01, :value => 1, :description => "Caucasisch (blank)"
    option :a02, :value => 2, :description => "Negroïde"
    option :a03, :value => 3, :description => "Aziatisch"
    option :a04, :value => 4, :description => "Indiaans / Latijns-Amerikaans"
    option :a05, :value => 5, :description => "Turks"
    option :a06, :value => 6, :description => "Marokkaans"
    option :a07, :value => 7, :description => "Anders" do
      question :v_179, :type => :string, :title => "namelijk", :required => true
    end
  end

end
