# WD-Extended

# Project ID 119942
# Date (GMT) 15-01-2010 08:49:18

key "wd-extended"
title "WD-Extended"
description ""

question :q80, :type => :open do
  title "Patiëntnummer"
  description ""
end

question :q81, :type => :open do
  title "Bevest Patiëntnr"
  description ""
end

question :q94, :type => :open do
  title "Geboortedatum: (Dag)"
  description ""
end

question :q95, :type => :open do
  title "Geboortedatum: (Maand)"
  description ""
end

question :q96, :type => :open do
  title "Geboortedatum: (Jaar)"
  description ""
end

question :q591498, :type => :radio do
  title "1. In slaap vallen:"
  description ""
  option :a1, :value => 1, :description => "Het duurt nooit langer dan 30 minuten om in slaap te vallen."
  option :a2, :value => 2, :description => "Het duurt tenminste 30 minuten om in slaap te vallen, minder dan de helft van de week."
  option :a3, :value => 3, :description => "Het duurt tenminste 30 minuten om in slaap te vallen, meer dan de helft van de week."
  option :a4, :value => 4, :description => "Het duurt tenminste 60 minuten om in slaap te vallen, meer dan de helft van de week."
end

question :q591592, :type => :radio do
  title "2. Slaap gedurende de nacht:"
  description ""
  option :a1, :value => 1, :description => "Ik word 's nachts niet wakker."
  option :a2, :value => 2, :description => "Ik slaap onrustig en licht en word een aantal keren per nacht even wakker."
  option :a3, :value => 3, :description => "Ik ben tenminste één keer per nacht klaar wakker, maar val weer gemakkelijk in slaap."
  option :a4, :value => 4, :description => "Ik word vaker dan één keer per nacht wakker en blijf dan 20 minuten of langer wakker, meer dan de helft van de week."
end

question :q591596, :type => :radio do
  title "3. Te vroeg wakker worden:"
  description ""
  option :a1, :value => 1, :description => "Meestal word ik niet eerder dan 30 minuten voordat ik op moet staan, wakker."
  option :a2, :value => 2, :description => "Ik word meer dan 30 minuten voordat ik op moet staan wakker, meer dan de helft van de tijd."
  option :a3, :value => 3, :description => "Ik word tenminste 1 uur voordat ik op moet staan wakker, meer dan de helft van de tijd."
  option :a4, :value => 4, :description => "Ik word tenminste 2 uur voordat ik op moet staan wakker, meer dan de helft van de tijd."
end

question :q591599, :type => :radio do
  title "4. Te veel slapen:"
  description ""
  option :a1, :value => 1, :description => "Ik slaap niet langer dan 7-8 uur per nacht, zonder overdag een dutje te doen."
  option :a2, :value => 2, :description => "Ik slaap niet langer dan 10 u binnen één etmaal (inclusief dutten)."
  option :a3, :value => 3, :description => "Ik slaap niet langer dan 12 u binnen één etmaal (inclusief dutten)."
  option :a4, :value => 4, :description => "Ik slaap langer dan 12 u binnen één etmaal (inclusief dutten)."
end

question :q591602, :type => :radio do
  title "5. Somber voelen:"
  description ""
  option :a1, :value => 1, :description => "Ik ben niet somber."
  option :a2, :value => 2, :description => "Ik ben minder dan de helft van de tijd somber."
  option :a3, :value => 3, :description => "Ik ben meer dan de helft van de tijd somber."
  option :a4, :value => 4, :description => "Ik ben bijna altijd somber."
end

question :q591605, :type => :radio do
  title "6. Prikkelbaar voelen:"
  description ""
  option :a1, :value => 1, :description => "Ik voel mij niet prikkelbaar."
  option :a2, :value => 2, :description => "Ik voel mij minder dan de helft van de tijd prikkelbaar."
  option :a3, :value => 3, :description => "Ik voel mij meer dan de helft van de tijd prikkelbaar."
  option :a4, :value => 4, :description => "Ik voel mij bijna altijd heel erg prikkelbaar."
end

question :q591608, :type => :radio do
  title "7. Angstig of gespannen voelen:"
  description ""
  option :a1, :value => 1, :description => "Ik voel mij niet angstig of gespannen."
  option :a2, :value => 2, :description => "Ik voel mij minder dan de helft van de tijd angstig of gespannen."
  option :a3, :value => 3, :description => "Ik voel mij meer dan de helft van de tijd angstig of gespannen."
  option :a4, :value => 4, :description => "Ik voel mij bijna altijd uiterst angstig of gespannen."
end

question :q591610, :type => :radio do
  title "8. De invloed van prettige gebeurtenissen op uw stemming:"
  description ""
  option :a1, :value => 1, :description => "Bij prettige gebeurtenissen verbetert de stemming gedurende een aantal uren tot een normaal niveau."
  option :a2, :value => 2, :description => "Bij prettige gebeurtenissen verbetert de stemming, maar ik voel mij niet zoals gewoonlijk."
  option :a3, :value => 3, :description => "Mijn stemming klaart slechts op bij een beperkt aantal zeer gewenste en aangename gebeurtenissen."
  option :a4, :value => 4, :description => "Mijn stemming klaart helemaal niet op, ook al gebeuren er prettige dingen in mijn leven."
end

question :q591613, :type => :radio do
  title "9. Stemming in relatie tot de tijd van de dag:"
  description ""
  option :a1, :value => 1, :description => "Er is geen duidelijk verband tussen mijn stemming en de tijd van de dag."
  option :a2, :value => 2, :description => "Mijn stemming houdt vaak verband met de tijd van de dag ten gevolge van omgevingsfactoren (bv. alléén zijn, werken)."
  option :a3, :value => 3, :description => "Over het algemeen is mijn stemming meer gerelateerd aan de tijd van de dag dan aan gebeurtenissen in mijn leven."
  option :a4, :value => 4, :description => "Mijn stemming is duidelijk en voorspelbaar beter of slechter op een bepaald tijdstip van de dag."
end

question :q591620, :type => :radio do
  title "9a. Uw stemming is typisch slechter in de ..."
  description ""
  option :a1, :value => 1, :description => "Ochtend"
  option :a2, :value => 2, :description => "Middag"
  option :a3, :value => 3, :description => "Avond"
end

question :q591622, :type => :radio do
  title "9b. Zijn uw stemmingswisselingen toe te schrijven aan de omgeving?"
  description ""
  option :a1, :value => 1, :description => "Ja"
  option :a2, :value => 2, :description => "Nee"
end

question :q591618, :type => :radio do
  title "10. Kwaliteit van uw stemming:"
  description ""
  option :a1, :value => 1, :description => "De stemming (innerlijke gevoelens) die ik ervaar is vaak een normale stemming."
  option :a2, :value => 2, :description => "Mijn stemming is somber, maar deze somberheid lijkt sterk op verdriet."
  option :a3, :value => 3, :description => "Mijn stemming is somber, maar deze somberheid is enigzins anders dan wat ik bij verdriet zou voelen."
  option :a4, :value => 4, :description => "Mijn stemming is somber, maar deze somberheid voelt geheel anders dan verdriet."
end

question :q591751, :type => :radio do
  title "11. Verminderde eetlust:"
  description ""
  option :a1, :value => 1, :description => "Mijn eetlust is niet anders dan gewoonlijk."
  option :a2, :value => 2, :description => "Ik eet wat minder vaak of kleinere hoeveelheden dan gewoonlijk."
  option :a3, :value => 3, :description => "Ik eet veel minder dan gewoonlijk en alleen met inspanning."
  option :a4, :value => 4, :description => "Ik eet nauwelijks binnen een etmaal en alleen met extreme inspanning of op aandringen van anderen."
end

question :q591753, :type => :radio do
  title "12. Toegenomen eetlust:"
  description ""
  option :a1, :value => 1, :description => "Mijn eetlust is niet anders dan gewoonlijk."
  option :a2, :value => 2, :description => "Ik voel vaker dan gewoonlijk de behoefte om te eten."
  option :a3, :value => 3, :description => "Ik eet regelmatig vaker en grotere hoeveelheden dan gewoonlijk."
  option :a4, :value => 4, :description => "Ik voel een sterke neiging om tijdens en tussen de maaltijden door te veel te eten."
end

question :q591763, :type => :radio do
  title "13. Gewichtsafname gedurende de afgelopen 2 weken:"
  description ""
  option :a1, :value => 1, :description => "Geen gewichtsverandering."
  option :a2, :value => 2, :description => "Ik heb het gevoel dat ik wat ben afgevallen."
  option :a3, :value => 3, :description => "Ik ben 1 kg of meer afgevallen."
  option :a4, :value => 4, :description => "Ik ben 2,5 kg of meer afgevallen."
end

question :q591764, :type => :radio do
  title "14. Gewichtstoename gedurende de afgelopen 2 weken:"
  description ""
  option :a1, :value => 1, :description => "Geen gewichtsverandering."
  option :a2, :value => 2, :description => "Ik heb het gevoel dat ik wat ben aangekomen."
  option :a3, :value => 3, :description => "Ik ben 1 kg of meer aangekomen."
  option :a4, :value => 4, :description => "Ik ben 2,5 kg of meer aangekomen."
end

question :q591769, :type => :radio do
  title "15. Concentratie/besluitvaardigheid:"
  description ""
  option :a1, :value => 1, :description => "Er is geen verandering in gebruikelijke concentratievermogen of in besluitvaardigheid."
  option :a2, :value => 2, :description => "Ik voel mij nu en dan besluiteloos of merk dat ik mijn aandacht er niet bij kan houden."
  option :a3, :value => 3, :description => "Ik heb bijna altijd grote moeite om mijn aandacht vast te houden en om beslissingen te nemen."
  option :a4, :value => 4, :description => "Ik kan mijn niet goed concentreren om te lezen of kan zelfs niet de kleinste beslissingen nemen."
end

question :q591773, :type => :radio do
  title "16. Zelfbeeld:"
  description ""
  option :a1, :value => 1, :description => "Ik vind mijzelf even waardevol en nuttig als een ander."
  option :a2, :value => 2, :description => "Ik maak mijzelf meer verwijten dan gewoonlijk."
  option :a3, :value => 3, :description => "Ik heb sterk de indruk dat ik anderen in moeilijkheden breng."
  option :a4, :value => 4, :description => "Ik denk voortdurend aan mijn grotere en kleinere tekortkomingen."
end

question :q591775, :type => :radio do
  title "17. Toekomstverwachting:"
  description ""
  option :a1, :value => 1, :description => "Ik heb een optimistische kijk op de toekomst."
  option :a2, :value => 2, :description => "Ik ben af en toe pessimistisch over mijn toekomst, maar meestal geloof ik dat het wel weer beter zal gaan."
  option :a3, :value => 3, :description => "Ik ben er vrij zeker van dat mijn nabije toekomst (1-2 maanden) niet veel goeds te bieden heeft."
  option :a4, :value => 4, :description => "Ik heb geen hoop dat mij in de toekomst iets goeds zal overkomen."
end

question :q591779, :type => :radio do
  title "18. Gedachten aan dood en zelfmoord:"
  description ""
  option :a1, :value => 1, :description => "Ik denk niet aan zelfmoord of aan de dood."
  option :a2, :value => 2, :description => "Ik heb het gevoel dat mijn leven leeg is en vraag me af of het nog de moeite waard is."
  option :a3, :value => 3, :description => "Ik denk enkele malen per week wel even aan zelfmoord of aan de dood."
  option :a4, :value => 4, :description => "Ik denk een aantal keren per dag serieus na over zelfmoord of de dood, óf ik heb zelfmoordplannen gemaakt, óf ik heb al een poging gedaan om mijn leven te beëindigen."
end

question :q591783, :type => :radio do
  title "19. Algemene interesse:"
  description ""
  option :a1, :value => 1, :description => "Geen verandering van mijn normale interesse in andere mensen en activiteiten."
  option :a2, :value => 2, :description => "Ik merk dat ik minder geïnteresseerd ben in anderen en in activiteiten."
  option :a3, :value => 3, :description => "Ik heb alleen nog geïnteresseerd in één of twee dingen die ik voorheen deed."
  option :a4, :value => 4, :description => "Ik heb vrijwel geen interesse meer in dingen die ik voorheen deed."
end

question :q591790, :type => :radio do
  title "20. Energie:"
  description ""
  option :a1, :value => 1, :description => "Geen verandering in mijn gebruikelijke energie."
  option :a2, :value => 2, :description => "Ik word sneller moe dan gewoonlijk."
  option :a3, :value => 3, :description => "Ik heb grote moeite met het beginnen aan of volhouden van gebruikelijke dagelijkse activiteiten (bv. boodschappen doen, huiswerk, koken of naar het werk gaan)."
  option :a4, :value => 4, :description => "Ik ben niet in staat om mijn normale dagelijkse activiteiten uit te voeren vanwege een gebrek aan energie."
end

question :q591798, :type => :radio do
  title "21. Plezier en genieten (seksuele leven buiten beschouwing laten):"
  description ""
  option :a1, :value => 1, :description => "Ik geniet net zoveel van aangename bezigheden als gewoonlijk."
  option :a2, :value => 2, :description => "Ik heb minder plezier in aangename bezigheden dan gewoonlijk."
  option :a3, :value => 3, :description => "Ik heb nauwelijks plezier bij welke activiteit dan ook."
  option :a4, :value => 4, :description => "Ik kan nergens meer van genieten."
end

question :q591800, :type => :radio do
  title "22. Belangstelling voor seks (scoor belangstelling en niet activiteit):"
  description ""
  option :a1, :value => 1, :description => "Ik heb evenveel belangstelling voor seks als gewoonlijk."
  option :a2, :value => 2, :description => "Mijn belangstelling voor seks is wat minder dan gewoonlijk, of ik beleef niet meer hetzelfde plezier aan seks als vroeger."
  option :a3, :value => 3, :description => "Ik heb weinig behoefte aan seks of beleef er zelden plezier aan."
  option :a4, :value => 4, :description => "Ik heb absoluut geen interesse in seks of beleef er geen plezier aan."
end

question :q591804, :type => :radio do
  title "23. Gevoel van traagheid:"
  description ""
  option :a1, :value => 1, :description => "Ik denk, spreek en beweeg in mijn normale tempo."
  option :a2, :value => 2, :description => "Mijn denken is vertraagd en mijn stem klinkt vlak en saai."
  option :a3, :value => 3, :description => "Ik heb enkele seconden nodig om te antwoorden op vragen, en mijn denken is zeker vertraagd."
  option :a4, :value => 4, :description => "Het kost me zeker veel moeite om te reageren op vragen."
end

question :q591812, :type => :radio do
  title "24. Rusteloos gevoel:"
  description ""
  option :a1, :value => 1, :description => "Ik voel mij niet rusteloos."
  option :a2, :value => 2, :description => "Ik ben vaak zenuwachtig, ik wring met mijn handen en ik kan niet rustig op een stoel zitten."
  option :a3, :value => 3, :description => "Ik heb de neiging te bewegen en ben nogal rusteloos."
  option :a4, :value => 4, :description => "Ik kan vaak niet stilzitten en loop dan te ijsberen."
end

question :q591818, :type => :radio do
  title "25. Pijnklachten:"
  description ""
  option :a1, :value => 1, :description => "Ik heb geen zwaar gevoel in mijn armen of benen en geen andere pijnklachten."
  option :a2, :value => 2, :description => "Soms heb ik hoofd-, buik-, rug- of gewrichtspijn, maar deze pijnen zijn af en toe aanwezig en blemmeren mij niet dingen te doen."
  option :a3, :value => 3, :description => "Bovenstaande pijnen heb ik vaak."
  option :a4, :value => 4, :description => "Deze pijnen zijn zo erg dat ik moet stoppen met mijn bezigheden."
end

question :q591828, :type => :radio do
  title "26. Andere lichamelijke klachten:"
  description ""
  option :a1, :value => 1, :description => "Ik heb geen last van versnelde of onregelmatige hartslag, wazig zien, zweten, warme en koude golven, oorsuizingen, pijn in de borst of beven."
  option :a2, :value => 2, :description => "Ik heb enkele van deze klachten maar ze zijn licht en slechts af en toe aanwezig."
  option :a3, :value => 3, :description => "Ik heb meerdere van deze klachten en heb daar behoorlijk last van."
  option :a4, :value => 4, :description => "Deze klachten zijn zo erg dat ik moet stoppen met mijn bezigheden."
end

question :q591833, :type => :radio do
  title "27. Paniek/Fobische klachten:"
  description ""
  option :a1, :value => 1, :description => "Ik heb geen paniekaanvallen of specifieke angsten (fobieën) zoals voor dieren of hoogtevrees."
  option :a2, :value => 2, :description => "Ik heb lichte paniekaanvallen of angsten die gewoonlijk mijn gedrag niet veranderen en mij niet verhinderen te functioneren."
  option :a3, :value => 3, :description => "Ik heb duidelijke paniekaanvallen of angsten waardoor ik mijn gedrag moet aanpassen, hoewel ik kan blijven functioneren."
  option :a4, :value => 4, :description => "Ik heb tenminste één keer per week paniekaanvallen of ernstige angsten waardoor ik mijn dagelijkse activiteiten moet onderbreken."
end

question :q591837, :type => :radio do
  title "28. Verstopping/Diarree:"
  description ""
  option :a1, :value => 1, :description => "Er is geen verandering in de normale stoelgang."
  option :a2, :value => 2, :description => "Ik heb af en toe last van lichte verstopping of diarree."
  option :a3, :value => 3, :description => "Ik heb vaak last van verstopping of diarree zonder dat dit mijn dagelijks functioneren beïvloedt."
  option :a4, :value => 4, :description => "Ik heb last van verstopping of diarree waarvoor ik medicatie neem of waardoor mijn dagelijkse activiteiten worden beïvloed."
end

question :q591844, :type => :radio do
  title "29. Gevoeligheid:"
  description ""
  option :a1, :value => 1, :description => "Ik voel mij niet snel afgewezen, gekleineerd, bekritiseerd of gekwetst door anderen."
  option :a2, :value => 2, :description => "Ik voel mij soms afgewezen, gekleineerd, bekritiseerd en gekwetst door anderen."
  option :a3, :value => 3, :description => "Ik voel mij vaak afgewezen, gekleineerd, bekritiseerd en gekwetst door anderen, maar dit heeft slechts weinig invloed op mijn relaties of werk."
  option :a4, :value => 4, :description => "Ik voel mij vaak afgewezen, gekleineerd, bekritiseerd en gekwetst door anderen en deze gevoelens verstoren mijn relaties en werk."
end

question :q591853, :type => :radio do
  title "30. Zwaar gevoel/Lichamelijke energie:"
  description ""
  option :a1, :value => 1, :description => "Ik ervaar geen zwaar gevoel in mijn lichaam en geen verminderde lichamelijke energie."
  option :a2, :value => 2, :description => "Ik ervaar af en toe een zwaar gevoel in mijn lichaam en het ontbreken van energie, maar zonder negatieve invloed op werk, school of op mijn activiteiten."
  option :a3, :value => 3, :description => "Meer dan de helft van de tijd heb ik een zwaar gevoel in mijn lichaam (ontbreken van lichamelijke energie)."
  option :a4, :value => 4, :description => "Ik voel mij een aantal uren per dag, een aantal dagen per week zwaar in mijn lichaam (ontbreken van lichamelijke energie)."
end

question :q591887, :type => :radio do
  title "A. Hebt u de afgelopen week lichamelijke klachten gehad?"
  description ""
  option :a1, :value => 1, :description => "Ja, namelijk %s"
  option :a2, :value => 2, :description => "Nee"
end

question :q999999, :type => :open do
  title "Namelijk:"
  description ""
end

question :q591892, :type => :radio do
  title "B. Hebt u de afgelopen week medicatie gebruikt?"
  description ""
  option :a1, :value => 1, :description => "Ja, namelijk %s"
  option :a2, :value => 2, :description => "Nee"
end

question :q999999, :type => :open do
  title "Namelijk:"
  description ""
end

question :q591894, :type => :radio do
  title "C. Hebt u de afgelopen week andere medische behandelingen ondergaan?"
  description ""
  option :a1, :value => 1, :description => "Ja, namelijk %s"
  option :a2, :value => 2, :description => "Nee"
end

question :q999999, :type => :open do
  title "Namelijk:"
  description ""
end

question :q591903, :type => :open do
  title "D. Wanneer begon uw laatste menstruatie ongeveer?"
  description ""
end

question :q44, :type => :open do
  title "(Dag)"
  description ""
end

question :q45, :type => :open do
  title "(Maand)"
  description ""
end

question :q46, :type => :open do
  title "(Jaar)"
  description ""
end

question :q591907, :type => :radio do
  title "1. Zijn er afgelopen week gebeurtenissen geweest, die u van belang vindt om te vermelden?"
  description ""
  option :a1, :value => 1, :description => "Ja, namelijk %s"
  option :a2, :value => 2, :description => "Nee"
end

question :q999999, :type => :open do
  title "Namelijk:"
  description ""
end

question :q591912, :type => :radio do
  title "2. Hebben deze gebeurtenissen een gunstige of ongunstige invloed gehad?"
  description ""
  option :a1, :value => 1, :description => "Gunstig"
  option :a2, :value => 2, :description => "Ongunstig"
end

question :q591954, :type => :radio do
  title "1. Ik voel me moe."
  description ""
  option :a1, :value => 1, :description => "nee, dat klopt niet"
  option :a2, :value => 2, :description => "2"
  option :a3, :value => 3, :description => "3"
  option :a4, :value => 4, :description => "4"
  option :a5, :value => 5, :description => "5"
  option :a6, :value => 6, :description => "6"
  option :a7, :value => 7, :description => "ja, dat klopt"
end

question :q592014, :type => :radio do
  title "2. Ik ben gauw moe."
  description ""
  option :a1, :value => 1, :description => "nee, dat klopt niet"
  option :a2, :value => 2, :description => "2"
  option :a3, :value => 3, :description => "3"
  option :a4, :value => 4, :description => "4"
  option :a5, :value => 5, :description => "5"
  option :a6, :value => 6, :description => "6"
  option :a7, :value => 7, :description => "ja, dat klopt"
end

question :q592015, :type => :radio do
  title "3. Ik voel me fit."
  description ""
  option :a1, :value => 1, :description => "nee, dat klopt niet"
  option :a2, :value => 2, :description => "2"
  option :a3, :value => 3, :description => "3"
  option :a4, :value => 4, :description => "4"
  option :a5, :value => 5, :description => "5"
  option :a6, :value => 6, :description => "6"
  option :a7, :value => 7, :description => "ja, dat klopt"
end

question :q592051, :type => :radio do
  title "4. Lichamelijk voel ik me uitgeput."
  description ""
  option :a1, :value => 1, :description => "nee, dat klopt niet"
  option :a2, :value => 2, :description => "2"
  option :a3, :value => 3, :description => "3"
  option :a4, :value => 4, :description => "4"
  option :a5, :value => 5, :description => "5"
  option :a6, :value => 6, :description => "6"
  option :a7, :value => 7, :description => "ja, dat klopt"
end

question :q1160754, :type => :radio do
  title "Heeft U de afgelopen week gewerkt?"
  description ""
  option :a1, :value => 1, :description => "Ja"
  option :a2, :value => 2, :description => "Nee"
end

question :q1160778, :type => :open do
  title "Hoeveel uur heeft u de afgelopen week gewerkt?"
  description ""
end

question :q1160781, :type => :radio do
  title "Hebt u zich de afgelopen week ziek gemeld?"
  description ""
  option :a1, :value => 1, :description => "Ja"
  option :a2, :value => 2, :description => "Nee"
end

question :q1160782, :type => :open do
  title "Voor hoeveel uur heeft u zich ziek gemeld?"
  description ""
end

question :q1783433, :type => :radio do
  title "Had dit ziek melden te maken met uw winterdepressie?"
  description ""
  option :a1, :value => 1, :description => "Ja"
  option :a2, :value => 2, :description => "Nee"
end

question :q1160784, :type => :radio do
  title "Op een schaal van 1 tot 10 waarbij 1 staat voor de slechtste prestatie die iemand kan hebben en 10 voor het meest optimaal presteren, hoe vindt u dat u de afgelopen week gemiddeld genomen tijdens het werk presteerde?"
  description ""
  option :a1, :value => 1, :description => "1 Slechterdanslecht"
  option :a2, :value => 2, :description => "2"
  option :a3, :value => 3, :description => "3"
  option :a4, :value => 4, :description => "4"
  option :a5, :value => 5, :description => "5"
  option :a6, :value => 6, :description => "6"
  option :a7, :value => 7, :description => "7"
  option :a8, :value => 8, :description => "8"
  option :a9, :value => 9, :description => "9"
  option :a10, :value => 10, :description => "10 OptimaalBeterkan niet"
end

