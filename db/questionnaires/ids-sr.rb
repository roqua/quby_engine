# IDS-SR:    Zelfinvullijst Depressieve Symptomen

# Project ID 495
# Date (GMT) 06-12-2010 20:46:35
# All values between 1 and 8 auto-recoded with -1
# Manual recodes: 9a+1; 2-9b

key "ids-sr"
title "Zelfinvullijst Depressieve Symptomen (IDS-SR)"
description ""

panel do
 title "IDS-SR:  Zelfinvullijst Depressieve Symptomen"
 text "De bedoeling van deze vragenlijst is om meer inzicht te krijgen in een aantal aspecten van uw stemming. 

De vragenlijst omvat 30 vragen. 

Vink bij elke vraag het antwoord aan dat de *afgelopen zeven dagen* het meest op u van toepassing was.

Klik op 'Volgende vraag' om verder te gaan."
end

panel do
question :v_1, :type => :radio do
  title "1. In slaap vallen:"
  description ""
  option :a1, :value => 0, :description => "Het duurt nooit langer dan 30 minuten om in slaap te vallen"
  option :a2, :value => 1, :description => "Het duurt tenminste 30 minuten om in slaap te vallen, minder dan de helft van de week"
  option :a3, :value => 2, :description => "Het duurt tenminste 30 minuten om in slaap te vallen, meer dan de helft van de week"
  option :a4, :value => 3, :description => "Het duurt meer dan 60 minuten om in slaap te vallen, meer dan de helft van de week"
end

question :v_2, :type => :radio do
  title "2. Slaap gedurende de nacht:"
  description ""
  option :a1, :value => 0, :description => "Ik word 's nachts niet wakker"
  option :a2, :value => 1, :description => "Ik slaap onrustig en licht en word een aantal keren per nacht even wakker"
  option :a3, :value => 2, :description => "Ik ben tenminste 'e'en keer per nacht klaar wakker, maar val weer gemakkelijk in slaap"
  option :a4, :value => 3, :description => "Ik word vaker dan 'e'en keer per nacht wakker en blijf dan 20 minuten of langer wakker, meer dan de helft van de week"
end

question :v_3, :type => :radio do
  title "3. Te vroeg wakker worden:"
  description ""
  option :a1, :value => 0, :description => "Meestal word ik niet eerder dan 30 minuten voordat ik op moet staan, wakker"
  option :a2, :value => 1, :description => "Ik word meer dan 30 minuten voordat ik op moet staan wakker, meer dan de helft van de tijd"
  option :a3, :value => 2, :description => "Ik word tenminste 1 uur voordat ik op moet staan wakker, meer dan de helft van de tijd"
  option :a4, :value => 3, :description => "Ik word tenminste 2 uur voordat ik op moet staan wakker, meer dan de helft van de tijd"
end

question :v_4, :type => :radio do
  title "4. Te veel slapen:"
  description ""
  option :a1, :value => 0, :description => "Ik slaap niet langer dan 7-8 uur per nacht, zonder overdag een dutje te doen"
  option :a2, :value => 1, :description => "Ik slaap niet langer dan 10 uur binnen 'e'en etmaal (inclusief dutten)"
  option :a3, :value => 2, :description => "Ik slaap niet langer dan 12 uur binnen 'e'en etmaal (inclusief dutten)"
  option :a4, :value => 3, :description => "Ik slaap langer dan 12 uur binnen 'e'en etmaal (inclusief dutten)"
end
end

panel do
question :v_5, :type => :radio do
  title "5. Somber voelen:"
  description ""
  option :a1, :value => 0, :description => "Ik ben niet somber"
  option :a2, :value => 1, :description => "Ik ben minder dan de helft van de tijd somber"
  option :a3, :value => 2, :description => "Ik ben meer dan de helft van de tijd somber"
  option :a4, :value => 3, :description => "Ik ben bijna altijd somber"
end

question :v_6, :type => :radio do
  title "6. Prikkelbaar voelen:"
  description ""
  option :a1, :value => 0, :description => "Ik voel mij niet prikkelbaar"
  option :a2, :value => 1, :description => "Ik voel mij minder dan de helft van de tijd prikkelbaar"
  option :a3, :value => 2, :description => "Ik voel mij meer dan de helft van de tijd prikkelbaar"
  option :a4, :value => 3, :description => "Ik voel mij bijna altijd heel erg prikkelbaar"
end

question :v_7, :type => :radio do
  title "7. Angstig of gespannen voelen:"
  description ""
  option :a1, :value => 0, :description => "Ik voel mij niet angstig of gespannen"
  option :a2, :value => 1, :description => "Ik voel mij minder dan de helft van de tijd angstig of gespannen"
  option :a3, :value => 2, :description => "Ik voel mij meer dan de helft van de tijd angstig of gespannen"
  option :a4, :value => 3, :description => "Ik voel mij bijna altijd uiterst angstig of gespannen"
end

question :v_8, :type => :radio do
  title "8. De invloed van prettige gebeurtenissen op uw stemming:"
  description ""
  option :a1, :value => 0, :description => "Bij prettige gebeurtenissen verbetert de stemming gedurende een aantal uren tot een normaal niveau"
  option :a2, :value => 1, :description => "Bij prettige gebeurtenissen verbetert de stemming, maar ik voel mij niet zoals gewoonlijk"
  option :a3, :value => 2, :description => "Mijn stemming klaart slechts op bij een beperkt aantal zeer gewenste en aangename gebeurtenissen"
  option :a4, :value => 3, :description => "Mijn stemming klaart helemaal niet op, ook al gebeuren er prettige dingen in mijn leven"
end
end

panel do
question :v_9, :type => :radio do
  title "9. Stemming in relatie tot de tijd van de dag:"
  description ""
  option :a1, :value => 0, :description => "Er is geen duidelijk verband tussen mijn stemming en de tijd van de dag"
  option :a2, :value => 1, :description => "Mijn stemming houdt vaak verband met de tijd van de dag tengevolge van omgevingsfactoren (bv all'e'en zijn, werken)"
  option :a3, :value => 2, :description => "Over het algemeen is mijn stemming meer gerelateerd aan de tijd van de dag dan aan gebeurtenissen in mijn leven"
  option :a4, :value => 3, :description => "Mijn stemming is duidelijk en voorspelbaar beter of slechter op een bepaald tijdstip van de dag"
end

question :v_33, :type => :radio do
  title "9a. Uw stemming is typisch slechter in de ..."
  description ""
  option :a1, :value => 1, :description => "Ochtend"
  option :a2, :value => 2, :description => "Middag"
  option :a3, :value => 3, :description => "Avond"
end

question :v_34, :type => :radio do
  title "9b. Zijn uw stemmingswisselingen toe te schrijven aan de omgeving?"
  description ""
  option :a1, :value => 1, :description => "Ja"
  option :a2, :value => 0, :description => "Nee"
end

question :v_12, :type => :radio do
  title "10. Kwaliteit van uw stemming:"
  description ""
  option :a1, :value => 0, :description => "De stemming (innerlijke gevoelens) die ik ervaar is vaak een normale stemming"
  option :a2, :value => 1, :description => "Mijn stemming is somber, maar deze somberheid lijkt sterk op verdriet"
  option :a3, :value => 2, :description => "Mijn stemming is somber, maar deze somberheid is enigszins anders dan wat ik bij verdriet zou voelen"
  option :a4, :value => 3, :description => "Mijn stemming is somber, maar deze somberheid voelt geheel anders dan verdriet"
end
end 

panel do
text "Beantwoord nu of vraag 11 of vraag 12"
question :v_13, :type => :radio do
  title "11. Verminderde eetlust:"
  description ""
  option :a1, :value => 0, :description => "Mijn eetlust is niet anders dan gewoonlijk"
  option :a2, :value => 1, :description => "Ik eet wat minder vaak of kleinere hoeveelheden dan gewoonlijk"
  option :a3, :value => 2, :description => "Ik eet veel minder dan gewoonlijk en alleen met inspanning"
  option :a4, :value => 3, :description => "Ik eet nauwelijks binnen een etmaal en alleen met extreme inspanning of op aandringen van anderen"
end

question :v_36, :type => :radio do
  title "12. Toegenomen eetlust:"
  description ""
  option :a1, :value => 0, :description => "Mijn eetlust is niet anders dan gewoonlijk"
  option :a2, :value => 1, :description => "Ik voel vaker dan gewoonlijk de behoefte om te eten"
  option :a3, :value => 2, :description => "Ik eet regelmatig vaker en grotere hoeveelheden dan gewoonlijk"
  option :a4, :value => 3, :description => "Ik voel een sterke neiging om tijdens en tussen de maaltijden door te veel te eten"
end

text "Beantwoord nu of vraag 13 of vraag 14"
question :v_15, :type => :radio do
  title "13. Gewichtsafname gedurende de afgelopen 2 weken:"
  description ""
  option :a1, :value => 0, :description => "Geen gewichtsverandering"
  option :a2, :value => 1, :description => "Ik heb het gevoel dat ik wat ben afgevallen"
  option :a3, :value => 2, :description => "Ik ben 1 kg of meer afgevallen"
  option :a4, :value => 3, :description => "Ik ben 2 1/2 kg of meer afgevallen"
end

question :v_37, :type => :radio do
  title "14. Gewichtstoename gedurende de afgelopen 2 weken:"
  description ""
  option :a1, :value => 0, :description => "Geen gewichtsverandering"
  option :a2, :value => 1, :description => "Ik heb het gevoel dat ik wat ben aangekomen"
  option :a3, :value => 2, :description => "Ik ben 1 kg of meer aangekomen"
  option :a4, :value => 3, :description => "Ik ben 2 1/2 kg of meer aangekomen"
end
end

panel do
text "Vink het antwoord aan dat de afgelopen zeven dagen het meest op u van toepassing was." 
question :v_17, :type => :radio do
  title "15. Concentratie / besluitvaardigheid:"
  description ""
  option :a1, :value => 0, :description => "Er is geen verandering in gebruikelijke concentratievermogen of in besluitvaardigheid"
  option :a2, :value => 1, :description => "Ik voel mij nu en dan besluiteloos of merk dat ik mijn aandacht er niet bij kan houden"
  option :a3, :value => 2, :description => "Ik heb bijna altijd grote moeite om mijn aandacht vast te houden en om beslissingen te nemen"
  option :a4, :value => 3, :description => "Ik kan mij niet goed genoeg concentreren om te lezen of kan zelfs niet de kleinste beslissingen nemen"
end

question :v_18, :type => :radio do
  title "16. Zelfbeeld:"
  description ""
  option :a1, :value => 0, :description => "Ik vind mijzelf even waardevol en nuttig als een ander"
  option :a2, :value => 1, :description => "maak mijzelf meer verwijten dan gewoonlijk"
  option :a3, :value => 2, :description => "Ik heb sterk de indruk dat ik anderen in moeilijkheden breng"
  option :a4, :value => 3, :description => "Ik denk voortdurend aan mijn grotere en kleinere tekortkomingen"
end

question :v_19, :type => :radio do
  title "17. Toekomstverwachting:"
  description ""
  option :a1, :value => 0, :description => "Ik heb een optimistische kijk op de toekomst"
  option :a2, :value => 1, :description => "Ik ben af en toe pessimistisch over mijn toekomst, maar meestal geloof ik dat het wel weer beter zal gaan"
  option :a3, :value => 2, :description => "Ik ben er vrij zeker van dat mijn nabije toekomst (1-2 maanden) niet veel goeds te bieden heeft"
  option :a4, :value => 3, :description => "Ik heb geen hoop dat mij in de toekomst iets goeds zal overkomen"
end

question :v_20, :type => :radio do
  title "18. Gedachten aan dood en zelfmoord:"
  description ""
  option :a1, :value => 0, :description => "Ik denk niet aan zelfmoord of aan de dood"
  option :a2, :value => 1, :description => "Ik heb het gevoel dat mijn leven leeg is en vraag me af of het nog de moeite waard is"
  option :a3, :value => 2, :description => "Ik denk enkele malen per week wel even aan zelfmoord of aan de dood"
  option :a4, :value => 3, :description => "Ik denk een aantal keren per dag serieus na over zelfmoord of de dood, 'of ik heb zelfmoordplannen gemaakt, 'of ik heb al een poging gedaan om mijn leven te be'eindigen"
end
end

panel do
text "Vink het antwoord aan dat de afgelopen zeven dagen het meest op u van toepassing was." 
question :v_21, :type => :radio do
  title "19. Algemene interesse:"
  description ""
  option :a1, :value => 0, :description => "Geen verandering van mijn normale interesse in andere mensen en activiteiten"
  option :a2, :value => 1, :description => "Ik merk dat ik minder ge'interesseerd ben in anderen en in activiteiten"
  option :a3, :value => 2, :description => "Ik heb alleen nog interesse in 'e'en of twee dingen die ik voorheen deed"
  option :a4, :value => 3, :description => "Ik heb vrijwel geen interesse meer in dingen die ik voorheen deed"
end

question :v_22, :type => :radio do
  title "20. Energie:"
  description ""
  option :a1, :value => 0, :description => "Geen verandering in mijn gebruikelijke energie"
  option :a2, :value => 1, :description => "Ik word sneller moe dan gewoonlijk"
  option :a3, :value => 2, :description => "Ik heb grote moeite met het beginnen aan of volhouden van gebruikelijke dagelijkse activiteiten (bijvoorbeeld boodschappen doen, huiswerk, koken, of naar het werk gaan)"
  option :a4, :value => 3, :description => "Ik ben niet in staat om mijn normale dagelijkse activiteiten uit te voeren vanwege een gebrek aan energie"
end

question :v_23, :type => :radio do
  title "21. Plezier en genieten (seksuele leven buiten beschouwing laten):"
  description ""
  option :a1, :value => 0, :description => "Ik geniet net zoveel van aangename bezigheden als gewoonlijk"
  option :a2, :value => 1, :description => "Ik heb minder plezier in aangename bezigheden dan gewoonlijk"
  option :a3, :value => 2, :description => "Ik heb nauwelijks plezier bij welke activiteit dan ook"
  option :a4, :value => 3, :description => "Ik kan nergens meer van genieten"
end

question :v_24, :type => :radio do
  title "22. Belangstelling voor seks (scoor belangstelling en niet activiteit):"
  description ""
  option :a1, :value => 0, :description => "Ik heb evenveel belangstelling voor seks als gewoonlijk"
  option :a2, :value => 1, :description => "Mijn belangstelling voor seks is wat minder dan gewoonlijk, of ik beleef niet meer hetzelfde plezier aan seks als vroeger"
  option :a3, :value => 2, :description => "Ik heb weinig behoefte aan seks of beleef er zelden plezier aan"
  option :a4, :value => 3, :description => "Ik heb absoluut geen interesse in seks of beleef er geen plezier aan"
end
end

panel do
text "Vink het antwoord aan dat de afgelopen zeven dagen het meest op u van toepassing was." 
question :v_25, :type => :radio do
  title "23. Gevoel van traagheid:"
  description ""
  option :a1, :value => 0, :description => "Ik denk, spreek en beweeg in mijn normale tempo"
  option :a2, :value => 1, :description => "Mijn denken is vertraagd en mijn stem klinkt vlak en saai"
  option :a3, :value => 2, :description => "Ik heb enkele seconden nodig om te antwoorden op vragen, en mijn denken is zeker vertraagd"
  option :a4, :value => 3, :description => "Het kost me zeker veel moeite om te reageren op vragen"
end

question :v_26, :type => :radio do
  title "24. Rusteloos gevoel:"
  description ""
  option :a1, :value => 0, :description => "Ik voel mij niet rusteloos"
  option :a2, :value => 1, :description => "Ik ben vaak zenuwachtig, ik wring met mijn handen en ik kan niet rustig op een stoel zitten"
  option :a3, :value => 2, :description => "Ik heb de neiging te bewegen en ben nogal rusteloos"
  option :a4, :value => 3, :description => "Ik kan vaak niet stilzitten en loop dan te ijsberen"
end

question :v_27, :type => :radio do
  title "25. Pijnklachten:"
  description ""
  option :a1, :value => 0, :description => "Ik heb geen zwaar gevoel in mijn armen of benen en geen andere pijnklachten"
  option :a2, :value => 1, :description => "Soms heb ik hoofd-, buik-, rug- of gewrichtspijn, maar deze pijnen zijn af en toe aanwezig en belemmeren mij niet dingen te doen"
  option :a3, :value => 2, :description => "Bovenstaande pijnen heb ik vaak"
  option :a4, :value => 3, :description => "Deze pijnen zijn zo erg dat ik moet stoppen met mijn bezigheden"
end

question :v_28, :type => :radio do
  title "26. Andere lichamelijke klachten:"
  description ""
  option :a1, :value => 0, :description => "Ik heb geen last van versnelde of onregelmatige hartslag, wazig zien, zweten, warme en koude golven, oorsuizingen, pijn in de borst of beven"
  option :a2, :value => 1, :description => "Ik heb enkele van deze klachten maar ze zijn licht en slechts af en toe aanwezig"
  option :a3, :value => 2, :description => "Ik heb meerdere van deze klachten en heb daar behoorlijk last van"
  option :a4, :value => 3, :description => "Deze klachten zijn zo erg dat ik moet stoppen met mijn bezigheden"
end
end

panel do
text "Vink het antwoord aan dat de afgelopen zeven dagen het meest op u van toepassing was." 
question :v_29, :type => :radio do
  title "27. Paniek / fobische klachten:"
  description ""
  option :a1, :value => 0, :description => "Ik heb geen paniekaanvallen of specifieke angsten (fobie'en) zoals voor dieren of hoogtevrees"
  option :a2, :value => 1, :description => "Ik heb lichte paniekaanvallen of angsten die gewoonlijk mijn gedrag niet veranderen en mij niet verhinderen te functioneren"
  option :a3, :value => 2, :description => "Ik heb duidelijke paniekaanvallen of angsten waardoor ik mijn gedrag moet aanpassen, hoewel ik kan blijven functioneren"
  option :a4, :value => 3, :description => "Ik heb tenminste 'e'en keer per week paniekaanvallen of ernstige angsten waardoor ik mijn dagelijkse activiteiten moet onderbreken"
end

question :v_30, :type => :radio do
  title "28. Verstopping / diarree:"
  description ""
  option :a1, :value => 0, :description => "Er is geen verandering in de normale stoelgang"
  option :a2, :value => 1, :description => "Ik heb af en toe last van lichte verstopping of diarree"
  option :a3, :value => 2, :description => "Ik heb vaak last van verstopping of diarree zonder dat dit mijn dagelijks functioneren be'invloedt"
  option :a4, :value => 3, :description => "Ik heb last van verstopping of diarree waarvoor ik medicatie neem of waardoor mijn dagelijkse activiteiten worden be'invloed"
end

question :v_31, :type => :radio do
  title "29. Gevoeligheid:"
  description ""
  option :a1, :value => 0, :description => "Ik voel mij niet snel afgewezen, gekleineerd, bekritiseerd of gekwetst door anderen"
  option :a2, :value => 1, :description => "Ik voel mij soms afgewezen, gekleineerd, bekritiseerd en gekwetst door anderen"
  option :a3, :value => 2, :description => "Ik voel mij vaak afgewezen, gekleineerd, bekritiseerd en gekwetst door anderen, maar dit heeft slechts weinig invloed op mijn relaties of werk"
  option :a4, :value => 3, :description => "Ik voel mij vaak afgewezen, gekleineerd, bekritiseerd en gekwetst door anderen en deze gevoelens verstoren mijn relaties en werk"
end

question :v_32, :type => :radio do
  title "30. Zwaar gevoel / lichamelijke energie:"
  description ""
  option :a1, :value => 0, :description => "Ik ervaar geen zwaar gevoel in mijn lichaam en geen verminderde lichamelijke energie"
  option :a2, :value => 1, :description => "Ik ervaar af en toe een zwaar gevoel in mijn lichaam en het ontbreken van energie, maar zonder negatieve invloed op werk, school of op mijn activiteiten"
  option :a3, :value => 2, :description => "Meer dan de helft van de tijd heb ik een zwaar gevoel in mijn lichaam (ontbreken van lichamelijke energie)"
  option :a4, :value => 3, :description => "Ik voel mij een aantal uren per dag, een aantal dagen per week zwaar in mijn lichaam (ontbreken van lichamelijke energie)"
end
end
end_panel

