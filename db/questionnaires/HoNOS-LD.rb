# HoNOS-LD

title "HoNOS-LD - Health of the Nation Outcome Scales for people with Learning Disabilities"

#Hier moet nog een instructie
#Houd bij het invullen de volgorde van de schalen aan.
#Gebruik geen informatie die in een eerdere schaal al is meegenomen, behalve voor schaal 10.
#Ga uit van de meest ernstige problemen/symptomen die zich de afgelopen vier weken (de scoringsperiode) hebben voorgedaan.
#Alle schalen hebben de volgende opbouw:
#0	geen probleem
#1	probleem in lichte mate aanwezig, vereist geen actie
#2	gematigd probleem, maar duidelijk aanwezig
#3	vrij ernstig probleem
#4	ernstig tot zeer ernstig probleem
#9	geen of onvoldoende informatie

abortable

panel do
title "Instructies bij het invullen van de HoNOS-LD"

text  "
* Scoor elke schaal in de volgorde van 1 - 18.
* Gebruik geen informatie die bij een vorig item al is meegenomen. 
* Maak een score van het gedrag van de persoon over de afgelopen vier weken. 
* Scoor het MEEST ERNSTIGE probleem dat zich gedurende de scoringsperiode heeft voorgedaan.
* Alle schalen hebben de volgende opbouw: 
  * 0 = geen probleem gedurende de scoringsperiode;
  * 1 = licht probleem;
  * 2 = matig probleem;
  * 3 = ernstig probleem;
  * 4 = zeer ernstig probleem.
* Gebruik de score 9 indien u het niet weet. 

Klik op 'Volgende vraag' om verder te gaan."
end

question :q01, :type => :radio, :required => true do
  title "1. Gedragsproblemen (gericht op anderen)"
  description "Betrek hierbij het gedrag dat is gericht op anderen. Kijk hierbij niet naar het gedrag dat is gericht op de persoon zelf (schaal 2) of voornamelijk op spullen en bezittingen of andere gedragingen (schaal 3). Scoor de risicofactoren zoals die op dit moment worden beoordeeld."
  option :a1, :value => 0, :description => "0 Geen gedragsproblemen gericht op anderen gedurende de scoringsperiode."
  option :a2, :value => 1, :description => "1 Geïrriteerdheid, ruzie zoekend gedrag, af en toe voorkomende verbale agressie."
  option :a3, :value => 2, :description => "2 Veelvoorkomend verbaal agressief gedrag, verbale dreigementen, af en toe agressieve gebaren, lastigvallen met pesterig gedrag (pesterij)."
  option :a4, :value => 3, :description => "3 Het risico of voorkomen van fysieke agressie, resulterend in verwonding van anderen waarvoor eerste hulp nodig is, of intensieve begeleiding ter voorkoming ervan."
  option :a5, :value => 4, :description => "4 Het risico of voorkomen van fysieke agressie die verwonding van anderen tot gevolg heeft die ernstig genoeg is om eerste hulp van een arts te zoeken, en die om continue supervisie of fysieke interventie vraagt ter voorkoming van dit gedrag (bijvoorbeeld bewegingsbeperking, medicatie of verwijdering uit de omgeving)."
  option :a9, :value => 9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :q02, :type => :radio, :required => true do
  title "2. Gedragsproblemen gericht op zichzelf (zelfverwonding)"
  description "Betrek hierbij alle vormen van zelfverwondend gedrag. Kijk hierbij niet naar het gedrag dat op anderen is gericht (schaal 1) of gedrag dat voornamelijk is gericht op spullen en bezittingen of andere gedragingen (schaal 3)."
  option :a1, :value => 0, :description => "0 Geen zelfverwondend gedrag gedurende de scoringsperiode."
  option :a2, :value => 1, :description => "1 Af en toe voorkomend zelfverwondend gedrag (bijvoorbeeld het aanraken van het gezicht); af en toe voorkomende voorbijgaande gedachten over zelfmoord."
  option :a3, :value => 2, :description => "2 Veelvoorkomend zelfverwondend gedrag dat niet resulteert in weefselbeschadiging (bijvoorbeeld rode plekken, beurse plekken, polskrassen)."
  option :a4, :value => 3, :description => "3 Het risico of voorkomen van zelfverwondend gedrag dat omkeerbare weefselbeschadiging, maar geen functieverlies tot gevolg heeft (bijvoorbeeld snijden, blauwe plekken, uittrekken van haren)."
  option :a5, :value => 4, :description => "4 Het risico of voorkomen van zelfverwondend gedrag dat onomkeerbare weefselbeschadiging en functieverlies tot gevolg heeft (ledemaatcontracturen, gezichtsbeperking, blijvende littekens in het gezicht) of een suïcidepoging."
  option :a9, :value => 9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :q03, :type => :radio, :required => true do
  title "3. Overige mentale en gedragsproblemen"
  description "Dit item is bedoeld om globaal gedragsproblemen te scoren die niet in schaal 1 of 2 worden beschreven. Kijk hierbij niet naar het gedrag dat is gericht op anderen (schaal 1) of gedrag, gericht op zelfverwonding (schaal 2). Scoor de meest in het oog springende aanwezige gedragingen.
Betrek hierbij: A, gedragsproblemen die leiden tot beschadiging van spullen en eigendommen; B, problemen met persoonlijk gedrag, bijvoorbeeld spugen, smeren met ontlasting, het opeten van rommel, het opwekken van overgeven, het voortdurend eten en drinken, het verzamelen van rommel en spulletjes, het vertonen van ongepast seksueel gedrag; C, wiegen en fladderen, stereotiep en ritualistisch gedrag; D, angsten, fobieën, obsessief of compulsief gedrag; E, andere gedragingen."
  option :a1, :value => 0, :description => "0 Geen gedragsproble(e)m(en) gedurende de scoringsperiode."
  option :a2, :value => 1, :description => "1 Af en toe voorkomend(e) gedragsproble(e)m(en), dat/die abnormaal of sociaal onacceptabel is/zijn."
  option :a3, :value => 2, :description => "2 Gedrag dat voldoende veelvuldig voorkomt en ernstig genoeg is om enige impact te hebben op het functioneren van de persoon zelf of anderen, of dat het eigen functioneren of dat van anderen in enige mate verstoort."
  option :a4, :value => 3, :description => "3 Gedrag dat voldoende veelvuldig voorkomt en ernstig genoeg is om een duidelijke impact te hebben op het functioneren van de persoon zelf of anderen, of dat het eigen functioneren of dat van anderen duidelijk verstoort, waardoor het noodzakelijk is de persoon van dichtbij te begeleiden ter voorkoming van het gedrag."
  option :a5, :value => 4, :description => "4 Voortdurend en ernstig probleemgedrag dat een zware impact heeft op en een ernstige verstoring kan geven van het functioneren, waardoor continue supervisie of fysieke interventie noodzakelijk is ter voorkoming van het gedrag."
  option :a9, :value => 9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :q04, :type => :radio, :required => true do
  title "4. Aandacht en concentratie"
  description "Betrek hierbij problemen die kunnen ontstaan door passiviteit, overactief gedrag, rusteloosheid, van de hak op de tak springen of aandachtstekort, overbeweeglijkheid of gedragsproblemen die een gevolg zijn van medicijnen."
  option :a1, :value => 0, :description => "0 Kan gedurende de scoringsperiode zonder ondersteuning aandacht en concentratie volhouden bij activiteiten/programma’s."
  option :a2, :value => 1, :description => "1 Kan aandacht en concentratie volhouden bij activiteiten/programma’s wanneer er af en toe aanwijzingen worden gegeven en supervisie wordt geboden."
  option :a3, :value => 2, :description => "2 Kan met regelmatige aanwijzingen en een regelmatige supervisie aandacht en concentratie volhouden bij activiteiten/programma’s."
  option :a4, :value => 3, :description => "3 Kan met constante aanwijzingen en een continue supervisie aandacht en concentratie kortstondig volhouden bij activiteiten/programma’s."
  option :a5, :value => 4, :description => "4 Kan niet deelnemen aan activiteiten en programma’s, zelfs niet met constante aanwijzingen en een continue supervisie."
  option :a9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :q05, :type => :radio, :required => true do
  title "5. Geheugen en oriëntatie"
  description "Betrek hierbij recent geheugenverlies en verslechtering van oriëntatie wat betreft tijd, plaats en persoon, als bijkomend probleem bij eerdere moeilijkheden."
  option :a1, :value => 0, :description => "0 Kan op een betrouwbare manier de weg vinden in bekende omgevingen en omgaan met bekende mensen."
  option :a2, :value => 1, :description => "1 Is meestal wel bekend met de omgeving en de personen, maar heeft wel enkele moeilijkheden bij het vinden van de juiste weg in situaties en omgang."
  option :a3, :value => 2, :description => "2 Kan met de omgeving en de personen daarin omgaan met incidentele steun en supervisie."
  option :a4, :value => 3, :description => "3 Kan met de omgeving en de personen daarin omgaan met regelmatige steun en supervisie."
  option :a5, :value => 4, :description => "4 Niet zichtbaar in staat om met mensen en omgevingen om te gaan en deze te herkennen."
  option :a9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :q06, :type => :radio, :required => true do
  title "6. Communicatie (begripsproblemen)"
  description "Betrek hierbij alle reactievormen op verbale communicatie, gebaren en aanwijzingen, indien noodzakelijk ondersteund met verwijzingen/aanwijzingen in de omgeving van de persoon."
  option :a1, :value => 0, :description => "0 In staat om in de moedertaal communicatie over persoonlijke behoeften en ervaringen te begrijpen gedurende de scoringsperiode."
  option :a2, :value => 1, :description => "1 In staat om groepen woorden/korte zinnen/aanwijzingen te begrijpen over de meeste behoeften."
  option :a3, :value => 2, :description => "2 In staat om sommige aanwijzingen, gebaren en losse woorden over basisbehoeften en eenvoudige opdrachten te begrijpen (eten, drinken, kom maar hier, ga maar, ga maar zitten, enz.)."
  option :a4, :value => 3, :description => "3 In staat om pogingen tot communicatie te accepteren en te herkennen zonder dat er sprake is van veel specifiek begrijpen (het reactiepatroon is niet bepaald door de manier van communiceren)."
  option :a5, :value => 4, :description => "4 Geen zichtbaar begrip van of reactie op communicatie."
  option :a9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :q07, :type => :radio, :required => true do
  title "7. Communicatie (problemen met expressie)"
  description "Betrek hierbij alle pogingen om behoeften duidelijk te maken en met anderen te communiceren (woorden, gebaren, aanwijzingen). Scoor het gedrag in de schalen 1, 2 en 3."
  option :a1, :value => 0, :description => "0 In staat om gedurende de scoringsperiode behoeften en ervaringen aan te geven."
  option :a2, :value => 1, :description => "1 In staat om behoeften uit te drukken ten opzichte van de hem/haar bekende personen."
  option :a3, :value => 2, :description => "2 Alleen in staat om basale behoeften tot uitdrukking te brengen (eten, drinken, toiletbezoek, enz.)"
  option :a4, :value => 3, :description => "3 In staat om de aanwezigheid van behoeften duidelijk te maken, maar kan niet specificeren (bijvoorbeeld schreeuwen of gillen bij honger, dorst of gevoelens van onbehagen)."
  option :a5, :value => 4, :description => "4 In het geheel niet in staat om behoeften of de aanwezigheid daarvan tot uiting te brengen."
  option :a9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :q08, :type => :radio, :required => true do
  title "8. Problemen die verband houden met hallucinaties en waanvoorstellingen"
  description "Betrek hierbij hallucinaties en waanvoorstellingen ongeachte de diagnose. Betrek hierbij alle suggestieve tekenen van hallucinaties en waanvoorstellingen (het reageren op abnormale ervaringen, bijvoorbeeld het horen van stemmen wanneer men alleen is)."
  option :a1, :value => 0, :description => "0 Geen tekenen van hallucinaties of waanvoorstellingen gedurende de scoringsperiode."
  option :a2, :value => 1, :description => "1 Af en toe vreemde of excentrieke gedachten of gedragingen die suggestief zijn voor 
hallucinaties of waanvoorstellingen."
  option :a3, :value => 2, :description => "2 Tekenen van hallucinaties of waanvoorstellingen met enige onrust of gedragsverstoring."
  option :a4, :value => 3, :description => "3 Tekenen van hallucinaties of waanvoorstellingen met een duidelijke onrust of gedragsverstoring."
  option :a5, :value => 4, :description => "4 De geestestoestand en het gedrag zijn ernstig en onomstotelijk aangedaan door het bestaan van hallucinaties en waanvoorstellingen met een ernstige onrust of gedragsverstoring."
  option :a9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :q09, :type => :radio, :required => true do
  title "9. Problemen die te maken hebben met stemmingsveranderingen"
  description "Betrek hierbij problemen die te maken hebben met een toestand van somberheid, een verheven stemming, gemengde stemmingen of stemmingswisselingen (wisselen tussen ongelukkig zijn, huilen en teruggetrokken gedrag aan de ene kant en opwinding en prikkelbaarheid aan de andere kant)."
  option :a1, :value => 0, :description => "0 Geen tekenen van stemmingsverandering tijdens de scoringsperiode."
  option :a2, :value => 1, :description => "1 Stemming aanwezig maar met een geringe impact (bijvoorbeeld melancholie)."
  option :a3, :value => 2, :description => "2 Stemmingsverandering veroorzaakt een duidelijke impact op het gedrag van de persoon of anderen (bijvoorbeeld huilbuien, afname van vaardigheden, terugtrekgedrag en interesseverlies)."
  option :a4, :value => 3, :description => "3 Stemmingsverandering veroorzaakt een ernstige impact op de persoon zelf of anderen (bijvoorbeeld ernstige apathie en verminderde reactie, ernstige agitatie en onrust)."
  option :a5, :value => 4, :description => "4 Depressie, hypomaan gedrag of stemmingswisselingen die een ernstige impact hebben op de persoon zelf en anderen (bijvoorbeeld ernstig gewichtsverlies als gevolg van anorexie of overactief gedrag, agitatie die zo ernstig is dat de persoon niet meer in staat is om betrokken te zijn bij zinvolle activiteiten)."
  option :a9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :q10, :type => :radio, :required => true do
  title "10. Slaapproblemen"
  description "Scoor hier niet de intensiteit van gedragsproblemen, die moet bij schaal 3 worden opgenomen.
Betrek hierbij het niet uitgeslapen zijn overdag, de duur van de slaap, de frequentie van en periodes waarin men wakker ligt en de variatie in het slaappatroon."
  option :a1, :value => 0, :description => "0 Geen probleem tijdens de scoringsperiode."
  option :a2, :value => 1, :description => "1 Af en toe een lichte slaapstoornis met af en toe wakker liggen."
  option :a3, :value => 2, :description => "2 Matige slaapstoornis met vaak wakker liggen of enige onuitgeslapenheid overdag."
  option :a4, :value => 3, :description => "3 Ernstige slaapstoornis of duidelijke onuitgeslapenheid overdag (bijvoorbeeld onrust/overactiviteit/vroeg wakker worden) in sommige nachten."
  option :a5, :value => 4, :description => "4 Zeer ernstige slaapstoornis met verstoord gedrag (bijvoorbeeld onrust/overactiviteit/vroeg 
ontwaken gedurende de meeste nachten)."
  option :a9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :q11, :type => :radio, :required => true do
  title "11. Problemen met eten en drinken"
  description "Betrek hierbij zowel gewichtstoename als -afname. Scoor hier niet pica; dit moet in schaal 3 worden gescoord. Deze schaal betreft niet problemen die worden ondervonden door mensen die zichzelf niet kunnen voeden (bijvoorbeeld mensen met een ernstige lichamelijke handicap)."
  option :a1, :value => 0, :description => "0 Geen probleem met de eetlust gedurende de scoringsperiode."
  option :a2, :value => 1, :description => "1 Geringe verandering in de eetlust."
  option :a3, :value => 2, :description => "2 Ernstige verandering in de eetlust zonder significante gewichtsverandering."
  option :a4, :value => 3, :description => "3 Ernstige verstoring met enige gewichtsverandering tijdens de scoringsperiode."
  option :a5, :value => 4, :description => "4 Zeer ernstige verstoring met een significante gewichtsverandering tijdens de scoringsperiode."
  option :a9, :value => 9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :q12, :type => :radio, :required => true do
  title "12. Lichamelijke problemen"
  description "Betrek hierbij ziektes door welke oorzaak dan ook die de mobiliteit, de zelfverzorging, het zien en horen onomstotelijk beïnvloeden (bijvoorbeeld dementie, schildklierproblemen, tremoren die de motorische vaardigheden aantasten). Kijk hierbij niet naar relatief stabiele fysieke handicaps (bijvoorbeeld cerebral palsy, hemiplegie). Gedragsstoornissen die worden veroorzaakt door fysieke problemen moeten worden gescoord in de schalen 1, 2 en 3 (bijvoorbeeld agressie veroorzakende constipatie)."
  option :a1, :value => 0, :description => "0 Geen toename van het onvermogen als gevolg van fysieke problemen tijdens de scoringsperiode."
  option :a2, :value => 1, :description => "1 Licht toegenomen onvermogen, bijvoorbeeld een virale aandoening, een verstuikte pols."
  option :a3, :value => 2, :description => "2 Duidelijk onvermogen dat begeleiding en supervisie nodig maakt."
  option :a4, :value => 3, :description => "3 Ernstig onvermogen dat enige hulp nodig maakt bij de basisbehoeften."
  option :a5, :value => 4, :description => "4 Totaal onvermogen dat hulp nodig maakt voor de meeste basisbehoeften, zoals eten, drinken, toiletbezoek (volledig afhankelijk)."
  option :a9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :q13, :type => :radio, :required => true do
  title "13. Toevallen (epileptische aanvallen)"
  description "Betrek hierbij alle typen toevallen (partieel, focaal, gegeneraliseerd, gemengd, enz.) om het kortetermijneffect op het dagelijks leven van het individu te scoren. Scoor de effecten van de toevallen. Kijk hierbij niet naar gedragsproblemen die worden veroorzaakt door of gepaard gaan met toevallen (gebruik daarvoor de schalen 1, 2 en 3)."
  option :a1, :value => 0, :description => "0 Geen toegenomen onvermogen als gevolg van fysieke problemen tijdens de scoringsperiode."
  option :a2, :value => 1, :description => "1 Af en toe aanvallen met een minimale directe impact op de dagelijkse activiteiten (bijvoorbeeld een korte herstelperiode na een toeval)."
  option :a3, :value => 2, :description => "2 Toevallen met een dermate hoge frequentie of ernst dat ze een significante en directe impact hebben op de dagelijkse activiteiten (de persoon is na een paar uur pas in staat om zijn activiteiten te hervatten)."
  option :a4, :value => 3, :description => "3 Toevallen met een dermate hoge frequentie of ernst dat ze een ernstige directe impact hebben op de dagelijkse activiteiten en eenvoudige eerste hulp voor verwondingen enz. vragen (bijvoorbeeld hervatting van activiteiten pas de volgende dag)."
  option :a5, :value => 4, :description => "4 Regelmatige slecht onder controle te brengen toevallen (die kunnen worden vergezeld van periodes van status epilepticus) die dringend klinische aandacht vragen."
  option :a9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :q14, :type => :radio, :required => true do
  title "14. Dagelijkse activiteiten thuis"
  description "Betrek hierbij vaardigheden als koken, schoonmaken en andere huishoudelijke taken. Scoor hier geen problemen met dagelijkse activiteiten buitenshuis (schaal 15). Scoor ook geen problemen met zelfverzorging (schaal 16). Scoor hier wat wordt gezien, zonder de oorzaak, zoals bijvoorbeeld handicap, motivatie, enz. erbij te betrekken. Scoor hier het gedrag dat zich voordoet en niet het potentiële gedrag van de persoon. Scoor het huidige niveau van het gedrag dat is bereikt met de bestaande ondersteuning."
  option :a1, :value => 0, :description => "0 De persoon doet dagelijkse activiteiten thuis of neemt daaraan deel."
  option :a2, :value => 1, :description => "1 Er zijn enige beperkingen bij het doen van of meedoen aan huishoudelijke taken."
  option :a3, :value => 2, :description => "2 Er zijn significante beperkingen bij het doen van of meedoen aan huishoudelijke taken (bijvoorbeeld er niet in slagen om de was te doen of op te ruimen, moeilijkheden hebben bij het bereiden van maaltijden)."
  option :a4, :value => 3, :description => "3 Ernstige beperkingen bij het doen van of meedoen aan huishoudelijke taken (bijvoorbeeld het huis ziet er verwaarloosd, smerig en onopgeruimd uit; geen huishoudelijke routine)."
  option :a5, :value => 4, :description => "4 Ernstige verwaarlozing of gevaar als gevolg van geen zichtbare bijdrage aan de 
dagelijkse activiteiten thuis."
  option :a9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :q15, :type => :radio, :required => true do
  title "15. Dagelijkse activiteiten buitenshuis"
  description "Betrek hierbij vaardigheden als omgaan met geld, winkelen, mobiliteit en het gebruik van vervoersmiddelen, enz. Kijk hierbij niet naar problemen met de dagelijkse activiteiten thuis (schaal 14). Scoor geen problemen met zelfverzorging (schaal 16). Scoor het huidige niveau met de bestaande ondersteuning."
  option :a1, :value => 0, :description => "0 Regelmatig gebruik van faciliteiten en openbare voorzieningen (bijvoorbeeld winkelen)."
  option :a2, :value => 1, :description => "1 Enige beperking in activiteit (bijvoorbeeld moeilijkheden met het gebruik van openbare voorzieningen of transport)."
  option :a3, :value => 2, :description => "2 Significante beperkingen in activiteit die te maken heeft met een van de volgende bezigheden: winkelen, gebruik van vervoersmiddelen, openbare voorzieningen."
  option :a4, :value => 3, :description => "3 Ernstige beperkingen in activiteit die te maken heeft met meer dan een van de volgende bezigheden: winkelen, gebruik van vervoersmiddelen, openbare voorzieningen."
  option :a5, :value => 4, :description => "4 Ernstige beperkingen in activiteit die te maken heeft met meer dan een van de volgende bezigheden: winkelen, gebruik van vervoersmiddelen, openbare voorzieningen."
  option :a9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :q16, :type => :radio, :required => true do
  title "16. Niveau van zelfverzorging"
  description "Scoor hier het gemiddelde niveau van functioneren bij zelfzorgactiviteiten, zoals eten, wassen, aankleden en toiletbezoek. Scoor het huidige niveau met de bestaande ondersteuning. Scoor datgene wat gezien wordt en niet de motivatie van de persoon."
  option :a1, :value => 0, :description => "0 Uiterlijk en persoonlijke hygiëne worden onderhouden."
  option :a2, :value => 1, :description => "1 Er zijn bepaalde tekortkomingen met betrekking tot het uiterlijk, de persoonlijke hygiëne en de aandacht voor de gezondheid (bijvoorbeeld slechte verzorging van het uiterlijk)."
  option :a3, :value => 2, :description => "2 Er zijn significante tekortkomingen met betrekking tot het uiterlijk, de persoonlijke hygiëne of de aandacht voor de gezondheid, waardoor er een probleem ontstaat met de sociale acceptatie, echter zonder dat er een gezondheidsrisico ontstaat (bijvoorbeeld lichaamsgeuren, onverzorgde haren of nagels)."
  option :a4, :value => 3, :description => "3 Ernstige tekortkomingen met betrekking tot het uiterlijk, de persoonlijke hygiëne of de aandacht voor de gezondheid, waardoor er een gezondheidsrisico ontstaat (bijvoorbeeld uitslag op de huid, tandvleesontsteking, onvolledig gekleed)."
  option :a5, :value => 4, :description => "4 Ernstige zelfverwaarlozing met ernstige problemen ten aanzien van uiterlijk, hygiëne en dieet, waardoor er een ernstig gezondheidsrisico ontstaat (bijvoorbeeld drukwonden)."
  option :a9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :q17, :type => :radio, :required => true do
  title "17. Problemen met relaties"
  description "Betrek hierbij effecten van relatieproblemen met familie, vrienden en hulpverleners (zowel residentieel als ook in dag- en vrijetijdsomgeving). Meet wat er gebeurt, zonder de oorzaak erin te betrekken, bijvoorbeeld iemand die goede relaties heeft met mensen, kan best problemen vertonen."
  option :a1, :value => 0, :description => "0 Positief en veelvuldig contact met familie, vrienden of hulpverleners."
  option :a2, :value => 1, :description => "1 In het algemeen positieve relaties, maar er is sprake van enige spanning of van 
beperkingen met betrekking tot het contact."
  option :a3, :value => 2, :description => "2 Er zijn een aantal positieve relaties, maar er is ook sprake van recente verbroken
contacten of verslechterde relaties."
  option :a4, :value => 3, :description => "3 Er zijn moeilijkheden bij het onderhouden van relaties, met het risico van het verbreken hiervan of verminderd contact."
  option :a5, :value => 4, :description => "4 Er zijn belangrijke relaties verbroken zonder voortzetting van het contact tot op heden."
  option :a9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :q18, :type => :radio, :required => true do
  title "18. Werk en activiteiten"
  description "Scoor hier het gemiddelde niveau van problemen met betrekking tot de kwaliteit van de dagomgeving. Houd rekening met de frequentie en de vraag of er sprake is van voldoende betrokkenheid met de dagactiviteiten en of deze passend zijn. Betrek factoren als gebrek aan een gekwalificeerde staf, gekwalificeerde uitrusting en geschiktheid ten aanzien van leeftijd en klinische condities. Scoor geen problemen met zelfverzorging (schaal 16)."
  option :a1, :value => 0, :description => "0 De persoon is volledig betrokken met een acceptabel scala aan activiteiten."
  option :a2, :value => 1, :description => "1 De persoon gebruikt een redelijk scala aan activiteiten, maar heeft enige beperking in de toegang tot deze activiteiten of de geschiktheid ervan staat ter discussie."
  option :a3, :value => 2, :description => "2 De persoon gebruikt een beperkt scala aan activiteiten, er is sprake van een beperkte beschikbaarheid of geschiktheid."
  option :a4, :value => 3, :description => "3 De persoon bezoekt dagactiviteiten onregelmatig."
  option :a5, :value => 4, :description => "4 De persoon heeft geen dagactiviteiten."
  option :a9, :description => "9 Geen of onvoldoende informatie voorhanden."
end