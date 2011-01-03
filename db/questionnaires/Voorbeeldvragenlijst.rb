# Regels met een hekje ervoor zijn commentaar

#title "string": De string komt als titel van de vragenlijst in het in het overzicht van vragenlijsten te staan
title "Voorbeeldvragenlijst"

#abortable: Laat een 'Onderbreken' knop zien op elke pagina van de vragenlijst.
# De vragenlijst wordt zonder validaties direct opgeslagen als er op deze knop gedrukt wordt.
abortable

#start_panel is een panel met een algemene welkomsttext over roqua
#De inhoud van de functie start_panel is aan te passen onder het tabje Function library
#Let op: Aanpassingen aan functies gelden voor alle vragenlijsten die die functies bevatten
start_panel

#panel do: een panel blok zet alle vragen, text, etc. tussen zijn 'do' en zijn 'end' op dezelfde pagina
#In de bulk view worden de panels allemaal samengenomen zodat er 1 grote pagina ontstaat
#Elke 'do', van panels en van questions, moet worden afgesloten met een end, wat tussen de 'do' en 'end' staat heet een blok
panel do 
  #text "string" : Tekst met opmaak die op de betreffende plaats in het paneel wordt geplaatst
  text "Text *met opmaak*: Voor alle opmaak opties zie http://daringfireball.net/projects/markdown/basics"

  #Je kan ook text van meerdere regels in een string zetten
  text "Dit is een tekst

van meerdere regels"

  #question :key, :type => :soort_type :Vragen moeten minstens een key en een type hebben
  #Woorden met een dubbele punt ervoor heten symbols, dit zijn een soort strings met de beperking dat er geen spaties of 
  #speciale tekens in mogen staan. Ze worden gebruikt om keys en de verschillende attributen voor questions en options mee op te geven.
  
  #Mogelijke types van vragen: :date, :string, :float, :integer, :radio en :check_box

  #Date question, onder de key van de vraag wordt de datum gescheiden met - tekens opgeslagen, dus dd-mm-jjjj
  #De keys van de dag, maand en jaar velden zijn de key van de hele vraag met _dd, _mm en _yyyy er achter geplakt
  #In dit geval dus :q01_dd, :q01_mm en q01_yyyy
  question :q01, :type => :date do
    #De title van een vraag komt dik voor de vraag te staan, hier kan je de vraagstelling in kwijt
    title "Datum"
  end
  
  #De keys van de dag, maand en jaar velden kan je ook zelf op geven.
  question :q02, :type => :date, :year_key => :v_01, :month_key => :v_02, :day_key => :v_03 do
    title "Datum"
  end

  question :q03, :type => :string do
    title "Textveld"
    #description: In questions kan je een description gebruiken om extra uitleg te geven bij een vraag
    description "Dit is een tekstveld"
  end
end #Deze end hoort bij de eerste panel do
#Het is handig om met inspringing aan te geven of je binnen een panel of een question blok zit of niet

panel do
  #De invoer van :date, :string, :float en :integer vragen kan je valideren met een zogenaamde regular expression
  #Hieronder een voorbeeld van hoe het formaat dd-mm-jjjj in cijfers kan verplichten
  question :q04, :type => :date do
    title "Datum"
    #Op alle validates_ kan je een uitleg meegeven in het :explanation attribuut die getoond wordt als de validatie niet slaagde
    validates_format_with /\d?\d-\d?\d-\d\d\d\d/, :explanation => "Voldoet niet aan formaat DD - 1 of 2 cijfers, MM - 1 of 2 cijfers, JJJJ - 4 cijfers"
  end

  #Integer vragen moeten een geheel getal meekrijgen
  #De uitleg die getoond wordt bij een foutief ingevulde :float of :integer kun je kwijt in :error_explanation
  #De invoer van float en integer questions worden als tekst in de database opgeslagen
  question :q05, :type => :integer, :error_explanation => "Deze vraag moet met een geheel getal beantwoord worden." do
    title "Geheel getal"
    #validates_in_range: verplicht de invoer in het opgegeven open bereik te liggen (eerste cijfer is het minimum, tweede het maximum)
    validates_in_range 1..50
    #Je kan ook alleen een minimum of een maximum opgeven (in dit geval door de voorgaande range overbodig)
    validates_minimum 1
    validates_maximum 50
  end

  question :q06, :type => :float, :error_explanation => "Deze vraag moet met een getal beantwoord worden, gebruik een punt . als scheidingsteken" do
    title "Getal"
    #Voor :float of :integer velden kan je ook de mogelijke opties beperken door ze in array notatie [1,2,3]
    #aan validates_one_of mee te geven.
    validates_one_of [1.1, 2.2, 3.3], :explanation => "Moet 1.1, 2.2 of 3.3 zijn"
  end

  #Vragen moeten ingevuld zijn als ze het attribuut :required => true hebben
  #Validaties worden niet op lege invoer uitgevoerd als een vraag niet op deze manier verplicht is gesteld
  question :q07, :type => :string, :required => true do   
    title "Verplicht textveld, mag alleen kleine letters bevatten"
    validates_format_with /[a-z]*/, :explanation => "Mag alleen kleine letters bevatten"
  end
end

panel do
  title "Panels kunnen een titel hebben."

  question :q19, :type => :radio, :presentation => :horizontal do
    title "Soms heb je een vraag met een lange vraagstelling. Deze kun je horizontaal laten weergeven met :presentation"
    option :a01, :value => 4, :description => "Optie 0"
    option :a02, :value => 2, :description => "Optie 1"
    option :a03, :value => 1, :description => "Optie 2"
  end

  text "Uiterlijk combineert het niet heel goed met dingen die niet horizontaal gelayout zijn, dus ik denk dat we die bij voorkeur niet op een en hetzelfde panel willen zetten. Doe je dat wel, dan krijg je namelijk zoals op dit panel."

  #Radio questions, een rij opties waar maar 1 van geselecteerd kan worden
  #De key van de geselecteerde optie wordt onder de key van de vraag opgeslagen
  question :q08, :type => :radio do
    title "Radio question"

    #option :key : elke optie heeft zijn eigen key en optioneel ook een value en een description
    #In tegenstelling tot de keys van questions kunnen de keys opties worden hergebruikt in verschillende questions
    option :a01, :value => 0, :description => "Optie 0"
    
    #Je kan aan een option subvragen hangen door er een do end blok achter te zetten met de betreffende questions er in
    #Deze zijn alleen in te vullen en te valideren als de bovenliggende optie is aangevinkt
    option :a02, :value => 1, :description => "Optie 1" do
      #Deze questions moeten een unieke key hebben en worden net zo opgeslagen als alle andere questions
      question :q08_a02_1, :type => :string, :title => "Subvraag 1", :required => true
      question :q08_a02_2, :type => :string, :title => "Subvraag 2", :required => true 
    end
  end
  
  #Radio questions kun je ook de waarden van laten zien met :show_values => true
  question :q103, :type => :radio, :show_values => true do
    title "Bij deze radio tonen we ook de value van elke optie"
    option :a01, :value => 0, :description => "goed"
    option :a02, :value => 1, :description => "beetje goed"
    option :a03, :value => 2, :description => "heel lang antwoord die hopelijk lang genoeg is om te moeten wrappen, maar ik zal nog wat typen om hem nog wat langer te laten worden. Hmm, nog niet helemaal lang genoeg. Nog meer tekst! Woorden! Zinnen! Bommen en granaten."
    option :a04, :value => 3, :description => "beetje slecht"
    option :a05, :value => 9, :description => "slecht"
  end

  #Schalen zijn net radio questions, alleen worden ze horizontaal naast elkaar weergegeven
  #De key van de geselecteerde optie wordt onder de key van de vraag opgeslagen
  #
  # Vraagtekst:   ( )  ( )  ( )  ( )  (*)  ( )
  #               goed                  slecht
  question :q104, :type => :scale do
    title "Wat vindt u van Quby"
    option :a01, :value => 0, :description => "goed"
    option :a02, :value => 1, :description => "beetje goed"
    option :a03, :value => 2, :description => "gemiddeld"
    option :a04, :value => 3, :description => "beetje slecht"
    option :a05, :value => 4, :description => "slecht"
  end

  question :q124, :type => :scale, :presentation => :horizontal do
    title "Deze is presentation => horizontal, zodat we daar een testcase voor hebben"
    option :a01, :value => 0, :description => "goed"
    option :a02, :value => 1, :description => "beetje goed"
    option :a03, :value => 2, :description => "gemiddeld"
    option :a04, :value => 3, :description => "beetje slecht"
    option :a05, :value => 4, :description => "slecht"
  end

  #Bij check boxes kan je meerdere opties aanvinken.
  #Het :check_all_option attribuut geeft aan welke checkbox alle andere checkboxes aan zet
  #Het :uncheck_all_option attribuut geeft aan welke checkbox alle andere checkboxes uit zet
  question :q09, :type => :check_box, :check_all_option => :a04, :uncheck_all_option => :a05 do
    title "Checkbox question"
    option :a01, :description => "Optie 0"
    option :a02, :description => "Optie 1"
    option :a03, :description => "Optie 2"
    option :a04, :description => "Alles"
    option :a05, :description => "Geen"
  end
end

panel do
  #Het is mogelijk om een optie van een :radio question andere questions te laten verbergen
  question :q10, :type => :radio do
    title "Verbergende radio question"

    #:hides_questions vraagt om een array van de keys van de vragen die verborgen moeten worden als die optie
    #geselecteerd is
    option :a00, :description => "Verbergt niks"
    #inner_title "string" : Gebruik inner_title om midden in een lijst van opties text weer te geven
    inner_title "De volgende twee opties verbergen vragen"
    option :a01, :hides_questions => [:q11], :description => "Verbergt de volgende vraag"
    option :a02, :hides_questions => [:q12, :q13], :description => "Verbergt alle vragen van het volgende panel, en daarmee ook het panel zelf"
  end
  
  #Verborgen vragen worden niet gevalideerd
  question :q11, :type => :string, :required => true do
    title "Wordt verborgen, maar is anders required"
  end
end

panel do
  question :q12, :type => :string, :required => true do
    title "Wordt verborgen, maar is anders required"
  end

  question :q13, :type => :string, :required => true do
    title "Wordt verborgen, maar is anders required"
  end
end

#end_panel is een panel met algemene afsluitende text over roqua
end_panel