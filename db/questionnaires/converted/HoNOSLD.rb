# HoNOSLD

# Project ID 738
# Date (GMT) 06-12-2010 20:45:46
# All values between 1 and 8 auto-recoded with -1
# No manual recodes needed

key "honosld"
title "HoNOS LD"
description ""

start_panel

question :v_1, :type => :radio do
  title "1. Gedragsproblemen (gericht op anderen)"
  description ""
  option :a1, :value => 0, :description => "0Geen gedragsproblemen gericht op anderen gedurende de scoringsperiode."
  option :a2, :value => 1, :description => "1Ge'irriteerdheid, ruzie zoekend gedrag, af en toe voorkomende verbale agressie."
  option :a3, :value => 2, :description => "2Veelvoorkomend verbaal agressief gedrag, verbale dreigementen, af en toe agressieve gebaren, lastigvallen met pesterig gedrag (pesterij)."
  option :a4, :value => 3, :description => "3Het risico of voorkomen van fysieke agressie, resulterend in verwonding van anderen waarvoor eerste hulp nodig is, of intensieve begeleiding ter voorkoming ervan."
  option :a5, :value => 4, :description => "4Het risico of voorkomen van fysieke agressie die verwonding van anderen tot gevolg heeft die ernstig genoeg is om eerste hulp van een arts te zoeken, en die om continue supervisie of fysieke interventie vraagt ter voorkoming van dit gedrag (bijvoorbeeld bewegingsbeperking, medicatie of verwijdering uit de omgeving)."
  option :a9, :value => 9, :description => "9Geen of onvoldoende informatie voorhanden."
end

question :v_2, :type => :radio do
  title "2. Gedragsproblemen gericht op zichzelf (zelfverwonding)"
  description ""
  option :a1, :value => 0, :description => "0Geen zelfverwondend gedrag gedurende de scoringsperiode."
  option :a2, :value => 1, :description => "1Af en toe voorkomend zelfverwondend gedrag (bijvoorbeeld het aanraken van het gezicht); af en toe voorkomende voorbijgaande gedachten over zelfmoord."
  option :a3, :value => 2, :description => "2Veelvoorkomend zelfverwondend gedrag dat niet resulteert in weefselbeschadiging (bijvoorbeeld rode plekken, beurse plekken, polskrassen)."
  option :a4, :value => 3, :description => "3Het risico of voorkomen van zelfverwondend gedrag dat omkeerbare weefselbeschadiging, maar geen functieverlies tot gevolg heeft (bijvoorbeeld snijden, blauwe plekken, uittrekken van haren)."
  option :a5, :value => 4, :description => "4Het risico of voorkomen van zelfverwondend gedrag dat onomkeerbare weefselbeschadiging en functieverlies tot gevolg heeft (ledemaatcontracturen, gezichtsbeperking, blijvende littekens in het gezicht) of een su'icidepoging."
  option :a9, :value => 9, :description => "9Geen of onvoldoende informatie voorhanden."
end

question :v_3, :type => :radio do
  title "3. Overige mentale en gedragsproblemen"
  description ""
  option :a1, :value => 0, :description => "0Geen gedragsproble(e)m(en) gedurende de scoringsperiode."
  option :a2, :value => 1, :description => "1Af en toe voorkomend(e) gedragsproble(e)m(en), dat/die abnormaal of sociaal onacceptabel is/zijn."
  option :a3, :value => 2, :description => "2Gedrag dat voldoende veelvuldig voorkomt en ernstig genoeg is om enige impact te hebben op het functioneren van de persoon zelf of anderen, of dat het eigen functioneren of dat van anderen in enige mate verstoort."
  option :a4, :value => 3, :description => "3Gedrag dat voldoende veelvuldig voorkomt en ernstig genoeg is om een duidelijke impact te hebben op het functioneren van de persoon zelf of anderen, of dat het eigen functioneren of dat van anderen duidelijk verstoort, waardoor het noodzakelijk is de persoon van dichtbij te begeleiden ter voorkoming van het gedrag."
  option :a5, :value => 4, :description => "4Voortdurend en ernstig probleemgedrag dat een zware impact heeft op en een ernstige verstoring kan geven van het functioneren, waardoor continue supervisie of fysieke interventie noodzakelijk is ter voorkoming van het gedrag."
  option :a9, :value => 9, :description => "9Geen of onvoldoende informatie voorhanden."
end

question :v_4, :type => :radio do
  title "4. Aandacht en concentratie"
  description ""
  option :a1, :value => 0, :description => "0Kan gedurende de scoringsperiode zonder ondersteuning aandacht en concentratie volhouden bij activiteiten/programma's."
  option :a2, :value => 1, :description => "1Kan aandacht en concentratie volhouden bij activiteiten/programma's wanneer er af en toe aanwijzingen worden gegeven en supervisie wordt geboden."
  option :a3, :value => 2, :description => "2Kan met regelmatige aanwijzingen en een regelmatige supervisie aandacht en concentratie volhouden bij activiteiten/programma's."
  option :a4, :value => 3, :description => "3Kan met constante aanwijzingen en een continue supervisie aandacht en concentratie kortstondig volhouden bij activiteiten/programma's."
  option :a5, :value => 4, :description => "4Kan niet deelnemen aan activiteiten en programma's, zelfs niet met constante aanwijzingen en een continue supervisie."
  option :a9, :value => 9, :description => "9Geen of onvoldoende informatie voorhanden."
end

question :v_5, :type => :radio do
  title "5. Geheugen en ori'entatie"
  description ""
  option :a1, :value => 0, :description => "0Kan op een betrouwbare manier de weg vinden in bekende omgevingen en omgaan met bekende mensen."
  option :a2, :value => 1, :description => "1Is meestal wel bekend met de omgeving en de personen, maar heeft wel enkele moeilijkheden bij het vinden van de juiste weg in situaties en omgang."
  option :a3, :value => 2, :description => "2Kan met de omgeving en de personen daarin omgaan met incidentele steun en supervisie."
  option :a4, :value => 3, :description => "3Kan met de omgeving en de personen daarin omgaan met regelmatige steun en supervisie."
  option :a5, :value => 4, :description => "4Niet zichtbaar in staat om met mensen en omgevingen om te gaan en deze te herkennen."
  option :a9, :value => 9, :description => "9Geen of onvoldoende informatie voorhanden."
end

question :v_6, :type => :radio do
  title "6. Communicatie (begripsproblemen)"
  description ""
  option :a1, :value => 0, :description => "0In staat om in de moedertaal communicatie over persoonlijke behoeften en ervaringen te begrijpen gedurende de scoringsperiode."
  option :a2, :value => 1, :description => "1In staat om groepen woorden/korte zinnen/aanwijzingen te begrijpen over de meeste behoeften."
  option :a3, :value => 2, :description => "2In staat om sommige aanwijzingen, gebaren en losse woorden over basisbehoeften en eenvoudige opdrachten te begrijpen (eten, drinken, kom maar hier, ga maar, ga maar zitten, enz.)."
  option :a4, :value => 3, :description => "3In staat om pogingen tot communicatie te accepteren en te herkennen zonder dat er sprake is van veel specifiek begrijpen (het reactiepatroon is niet bepaald door de manier van communiceren)."
  option :a5, :value => 4, :description => "4Geen zichtbaar begrip van of reactie op communicatie."
  option :a9, :value => 9, :description => "9Geen of onvoldoende informatie voorhanden."
end

question :v_7, :type => :radio do
  title "7. Communicatie (problemen met expressie)"
  description ""
  option :a1, :value => 0, :description => "0In staat om gedurende de scoringsperiode behoeften en ervaringen aan te geven."
  option :a2, :value => 1, :description => "2In staat om behoeften uit te drukken ten opzichte van de hem/haar bekende personen."
  option :a3, :value => 2, :description => "2Alleen in staat om basale behoeften tot uitdrukking te brengen (eten, drinken, toiletbezoek, enz.)"
  option :a4, :value => 3, :description => "3In staat om de aanwezigheid van behoeften duidelijk te maken, maar kan niet specificeren (bijvoorbeeld schreeuwen of gillen bij honger, dorst of gevoelens van onbehagen)."
  option :a5, :value => 4, :description => "4In het geheel niet in staat om behoeften of de aanwezigheid daarvan tot uiting te brengen."
  option :a9, :value => 9, :description => "9Geen of onvoldoende informatie voorhanden."
end

question :v_8, :type => :radio do
  title "8. Problemen die verband houden met hallucinaties en waanvoorstellingen"
  description ""
  option :a1, :value => 0, :description => "0Geen tekenen van hallucinaties of waanvoorstellingen gedurende de scoringsperiode."
  option :a2, :value => 1, :description => "1Af en toe vreemde of excentrieke gedachten of gedragingen die suggestief zijn voor hallucinaties of waanvoorstellingen."
  option :a3, :value => 2, :description => "2Tekenen van hallucinaties of waanvoorstellingen met enige onrust of gedragsverstoring."
  option :a4, :value => 3, :description => "3Tekenen van hallucinaties of waanvoorstellingen met een duidelijke onrust of gedragsverstoring."
  option :a5, :value => 4, :description => "4De geestestoestand en het gedrag zijn ernstig en onomstotelijk aangedaan door het bestaan van hallucinaties en waanvoorstellingen met een ernstige onrust of gedragsverstoring."
  option :a9, :value => 9, :description => "9Geen of onvoldoende informatie voorhanden."
end

question :v_11, :type => :radio do
  title "9. Problemen die te maken hebben met stemmingsveranderingen"
  description ""
  option :a1, :value => 0, :description => "0Geen tekenen van stemmingsverandering tijdens de scoringsperiode."
  option :a2, :value => 1, :description => "1Stemming aanwezig maar met een geringe impact (bijvoorbeeld melancholie)."
  option :a3, :value => 2, :description => "2Stemmingsverandering veroorzaakt een duidelijke impact op het gedrag van de persoon of anderen (bijvoorbeeld huilbuien, afname van vaardigheden, terugtrekgedrag en interesseverlies)."
  option :a4, :value => 3, :description => "3Stemmingsverandering veroorzaakt een ernstige impact op de persoon zelf of anderen (bijvoorbeeld ernstige apathie en verminderde reactie, ernstige agitatie en onrust)."
  option :a5, :value => 4, :description => "4Depressie, hypomaan gedrag of stemmingswisselingen die een ernstige impact hebben op de persoon zelf en anderen (bijvoorbeeld ernstig gewichtsverlies als gevolg van anorexie of overactief gedrag, agitatie die zo ernstig is dat de persoon niet meer in staat is om betrokken te zijn bij zinvolle activiteiten)."
  option :a9, :value => 9, :description => "9Geen of onvoldoende informatie voorhanden."
end

question :v_14, :type => :radio do
  title "10. Slaapproblemen"
  description ""
  option :a1, :value => 0, :description => "0Geen probleem tijdens de scoringsperiode."
  option :a2, :value => 1, :description => "1Af en toe een lichte slaapstoornis met af en toe wakker liggen."
  option :a3, :value => 2, :description => "2Matige slaapstoornis met vaak wakker liggen of enige onuitgeslapenheid overdag."
  option :a4, :value => 3, :description => "3Ernstige slaapstoornis of duidelijke onuitgeslapenheid overdag (bijvoorbeeld onrust/overactiviteit/vroeg wakker worden) in sommige nachten."
  option :a5, :value => 4, :description => "4Zeer ernstige slaapstoornis met verstoord gedrag (bijvoorbeeld onrust/overactiviteit/vroeg ontwaken gedurende de meeste nachten)."
  option :a9, :value => 9, :description => "9Geen of onvoldoende informatie voorhanden."
end

question :v_15, :type => :radio do
  title "11. Problemen met eten en drinken"
  description ""
  option :a1, :value => 0, :description => "0Geen probleem met de eetlust gedurende de scoringsperiode."
  option :a2, :value => 1, :description => "1Geringe verandering in de eetlust."
  option :a3, :value => 2, :description => "2Ernstige verandering in de eetlust zonder significante gewichtsverandering."
  option :a4, :value => 3, :description => "3Ernstige verstoring met enige gewichtsverandering tijdens de scoringsperiode."
  option :a5, :value => 4, :description => "4Zeer ernstige verstoring met een significante gewichtsverandering tijdens de scoringsperiode."
  option :a9, :value => 9, :description => "9Geen of onvoldoende informatie voorhanden."
end

question :v_16, :type => :radio do
  title "12. Lichamelijke problemen"
  description ""
  option :a1, :value => 0, :description => "0Geen toename van het onvermogen als gevolg van fysieke problemen tijdens de scoringsperiode."
  option :a2, :value => 1, :description => "1Licht toegenomen onvermogen, bijvoorbeeld een virale aandoening, een verstuikte pols."
  option :a3, :value => 2, :description => "2Duidelijk onvermogen dat begeleiding en supervisie nodig maakt."
  option :a4, :value => 3, :description => "3Ernstig onvermogen dat enige hulp nodig maakt bij de basisbehoeften."
  option :a5, :value => 4, :description => "4Totaal onvermogen dat hulp nodig maakt voor de meeste basisbehoeften, zoals eten, drinken, toiletbezoek (volledig afhankelijk)."
  option :a9, :value => 9, :description => "9Geen of onvoldoende informatie voorhanden."
end

question :v_51, :type => :radio do
  title "13. Toevallen (epileptische aanvallen)"
  description ""
  option :a1, :value => 0, :description => "0Geen toegenomen onvermogen als gevolg van fysieke problemen tijdens de scoringsperiode."
  option :a2, :value => 1, :description => "1Af en toe aanvallen met een minimale directe impact op de dagelijkse activiteiten (bijvoorbeeld een korte herstelperiode na een toeval)."
  option :a3, :value => 2, :description => "2Toevallen met een dermate hoge frequentie of ernst dat ze een significante en directe impact hebben op de dagelijkse activiteiten (de persoon is na een paar uur pas in staat om zijn activiteiten te hervatten)."
  option :a4, :value => 3, :description => "3Toevallen met een dermate hoge frequentie of ernst dat ze een ernstige directe impact hebben op de dagelijkse activiteiten en eenvoudige eerste hulp voor verwondingen enz. vragen (bijvoorbeeld hervatting van activiteiten pas de volgende dag)."
  option :a5, :value => 4, :description => "4Regelmatige slecht onder controle te brengen toevallen (die kunnen worden vergezeld van periodes van status epilepticus) die dringend klinische aandacht vragen."
  option :a9, :value => 9, :description => "9Geen of onvoldoende informatie voorhanden."
end

question :v_52, :type => :radio do
  title "14. Dagelijkse activiteiten thuis"
  description ""
  option :a1, :value => 0, :description => "0De persoon doet dagelijkse activiteiten thuis of neemt daaraan deel."
  option :a2, :value => 1, :description => "1Er zijn enige beperkingen bij het doen van of meedoen aan huishoudelijke taken."
  option :a3, :value => 2, :description => "2Er zijn significante beperkingen bij het doen van of meedoen aan huishoudelijke taken (bijvoorbeeld er niet in slagen om de was te doen of op te ruimen, moeilijkheden hebben bij het bereiden van maaltijden)."
  option :a4, :value => 3, :description => "3Ernstige beperkingen bij het doen van of meedoen aan huishoudelijke taken (bijvoorbeeld het huis ziet er verwaarloosd, smerig en onopgeruimd uit; geen huishoudelijke routine)."
  option :a5, :value => 4, :description => "4Ernstige verwaarlozing of gevaar als gevolg van geen zichtbare bijdrage aan de dagelijkse activiteiten thuis."
  option :a9, :value => 9, :description => "9Geen of onvoldoende informatie voorhanden."
end

question :v_53, :type => :radio do
  title "15. Dagelijkse activiteiten buitenshuis"
  description ""
  option :a1, :value => 0, :description => "0Regelmatig gebruik van faciliteiten en openbare voorzieningen (bijvoorbeeld winkelen)."
  option :a2, :value => 1, :description => "1Enige beperking in activiteit (bijvoorbeeld moeilijkheden met het gebruik van openbare voorzieningen of transport)."
  option :a3, :value => 2, :description => "2Significante beperkingen in activiteit die te maken heeft met een van de volgende bezigheden: winkelen, gebruik van vervoersmiddelen, openbare voorzieningen."
  option :a4, :value => 3, :description => "3Ernstige beperkingen in activiteit die te maken heeft met meer dan een van de volgende bezigheden: winkelen, gebruik van vervoersmiddelen, openbare voorzieningen."
  option :a5, :value => 4, :description => "4Zeer ernstige beperkingen in het gebruik van winkels, vervoersmiddelen, faciliteiten, enz."
  option :a9, :value => 9, :description => "9Geen of onvoldoende informatie voorhanden."
end

question :v_54, :type => :radio do
  title "16. Niveau van zelfverzorging"
  description ""
  option :a1, :value => 0, :description => "0Uiterlijk en persoonlijke hygi'ene worden onderhouden."
  option :a2, :value => 1, :description => "1Er zijn bepaalde tekortkomingen met betrekking tot het uiterlijk, de persoonlijke hygi'ene en de aandacht voor de gezondheid (bijvoorbeeld slechte verzorging van het uiterlijk)."
  option :a3, :value => 2, :description => "2Er zijn significante tekortkomingen met betrekking tot het uiterlijk, de persoonlijke hygi'ene of de aandacht voor de gezondheid, waardoor er een probleem ontstaat met de sociale acceptatie, echter zonder dat er een gezondheidsrisico ontstaat (bijvoorbeeld lichaamsgeuren, onverzorgde haren of nagels)."
  option :a4, :value => 3, :description => "3Ernstige tekortkomingen met betrekking tot het uiterlijk, de persoonlijke hygi'ene of de aandacht voor de gezondheid, waardoor er een gezondheidsrisico ontstaat (bijvoorbeeld uitslag op de huid, tandvleesontsteking, onvolledig gekleed)."
  option :a5, :value => 4, :description => "4Ernstige zelfverwaarlozing met ernstige problemen ten aanzien van uiterlijk, hygi'ene en dieet, waardoor er een ernstig gezondheidsrisico ontstaat (bijvoorbeeld drukwonden)."
  option :a9, :value => 9, :description => "9Geen of onvoldoende informatie voorhanden."
end

question :v_55, :type => :radio do
  title "17. Problemen met relaties"
  description ""
  option :a1, :value => 0, :description => "0Positief en veelvuldig contact met familie, vrienden of hulpverleners."
  option :a2, :value => 1, :description => "1In het algemeen positieve relaties, maar er is sprake van enige spanning of van beperkingen met betrekking tot het contact."
  option :a3, :value => 2, :description => "2Er zijn een aantal positieve relaties, maar er is ook sprake van recente verbroken contacten of verslechterde relaties."
  option :a4, :value => 3, :description => "3Er zijn moeilijkheden bij het onderhouden van relaties, met het risico van het verbreken hiervan of verminderd contact."
  option :a5, :value => 4, :description => "4Er zijn belangrijke relaties verbroken zonder voortzetting van het contact tot op heden."
  option :a9, :value => 9, :description => "9Geen of onvoldoende informatie voorhanden."
end

question :v_56, :type => :radio do
  title "18. Werk en activiteiten"
  description ""
  option :a1, :value => 0, :description => "0De persoon is volledig betrokken met een acceptabel scala aan activiteiten."
  option :a2, :value => 1, :description => "1De persoon gebruikt een redelijk scala aan activiteiten, maar heeft enige beperking in de toegang tot deze activiteiten of de geschiktheid ervan staat ter discussie."
  option :a3, :value => 2, :description => "2De persoon gebruikt een beperkt scala aan activiteiten, er is sprake van een beperkte beschikbaarheid of geschiktheid."
  option :a4, :value => 3, :description => "3De persoon bezoekt dagactiviteiten onregelmatig."
  option :a5, :value => 4, :description => "4De persoon heeft geen dagactiviteiten."
  option :a9, :value => 9, :description => "9Geen of onvoldoende informatie voorhanden."
end

end_panel

