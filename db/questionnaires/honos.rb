# HoNOS

# Project ID 52663
# Date (GMT) 15-01-2010 09:28:47

key "honos"
title "HoNOS"
description ""

question :v_1, :type => :radio do
  title "1. Hyperactief, agressief, destructief of geagiteerd gedrag"
  description ""
  option :a1, :value => 1, :description => "0Geen problemen van deze aard gedurende de afgelopen periode."
  option :a2, :value => 2, :description => "1Geïrriteerdheid, ruzies, rusteloosheid etc, maar vereist geen actie."
  option :a3, :value => 3, :description => "2Omvat agressieve gebaren, opdringerig of lastig vallen van anderen; bedreigingen of verbale agressie; kleinere schade aan eigendommen (zoals gebroken kopjes of raam); duidelijke hyperactiviteit of agitatie."
  option :a4, :value => 4, :description => "3Fysiek agressief naar mens of dier; dreigende houding; meer ernstige hyperactiviteit of vernieling van eigendommen."
  option :a5, :value => 5, :description => "4Minstens één ernstige fysieke aanval op mens of dier; vernielen van eigendommen (bijvoorbeeld brandstichting); ernstige intimidatie of aanstootgevend gedrag."
  option :a9, :value => 9, :description => "9Geen of onvoldoende informatie voorhanden."
end

question :v_2, :type => :radio do
  title "2. Opzettelijke zelfverwonding"
  description ""
  option :a1, :value => 1, :description => "0Geen problemen van deze aard gedurende de afgelopen periode."
  option :a2, :value => 2, :description => "1Voorbijgaande gedachten over zelfmoord maar gering risico de afgelopen periode; geen zelfverwonding."
  option :a3, :value => 3, :description => "2Licht risico gedurende de afgelopen periode; omvat ongevaarlijke zelfverwonding (zoals krassen in de pols)."
  option :a4, :value => 4, :description => "3Matig tot ernstig risico voor opzettelijke zelfverwonding gedurende de afgelopen periode; omvat voorbereidende activiteiten (zoals verzamelen van tabletten)."
  option :a5, :value => 5, :description => "4Ernstige suïcidepoging en/of ernstige opzettelijke zelfverwonding de afgelopen periode."
  option :a9, :value => 9, :description => "9Geen of onvoldoende informatie voorhanden."
end

question :v_3, :type => :radio do
  title "3. Problematisch alcohol- of druggebruik"
  description ""
  option :a1, :value => 1, :description => "0Geen problemen van deze aard gedurende de afgelopen periode."
  option :a2, :value => 2, :description => "1Enig overmatig gebruik, maar binnen de sociale norm."
  option :a3, :value => 3, :description => "2Verlies van controle over alcohol- of druggebruik, maar niet ernstig verslaafd."
  option :a4, :value => 4, :description => "3Duidelijke zucht naar of afhankelijkheid van alcohol of drugs met frequent controleverlies; risicoŽs nemen onder invloed."
  option :a5, :value => 5, :description => "4Incapabel door alcohol- of drugs problemen."
  option :a9, :value => 9, :description => "9Geen of onvoldoende informatie voorhanden."
end

question :v_4, :type => :radio do
  title "4. Cognitieve problemen"
  description ""
  option :a1, :value => 1, :description => "0Geen problemen van deze aard gedurende de afgelopen periode."
  option :a2, :value => 2, :description => "1Ondergeschikte problemen met geheugen en begripsvermogen (bijvoorbeeld zo nu en dan vergeten van namen)."
  option :a3, :value => 3, :description => "2Licht, maar duidelijk aanwezige problemen (bijvoorbeeld verdwaald in een bekende omgeving, niet herkennen van een bekende); soms in verwarring bij het nemen van simpele beslissingen."
  option :a4, :value => 4, :description => "3Duidelijke desoriëntatie in tijd, plaats of persoon; in de war gebracht door dagelijkse gebeurtenissen; zo nu en dan incoherente spraak; vertraagd denken."
  option :a5, :value => 5, :description => "4Ernstige desoriëntatie (bijvoorbeeld niet herkennen van familie); gevaar voor ongelukken; onbegrijpelijk taalgebruik; verlaagd bewustzijn of stupor."
  option :a9, :value => 9, :description => "9Geen of onvoldoende informatie voorhanden."
end

question :v_5, :type => :radio do
  title "5. Lichamelijke problemen of handicaps"
  description ""
  option :a1, :value => 1, :description => "0Geen lichamelijke gezondheidsproblemen gedurende de afgelopen periode."
  option :a2, :value => 2, :description => "1Ondergeschikte gezondheidsproblemen gedurende de afgelopen periode (bijvoorbeeld verkoudheid, niet ernstige val)."
  option :a3, :value => 3, :description => "2Lichamelijke gezondheidsproblemen leiden tot lichte beperking in mobiliteit en activi-teiten."
  option :a4, :value => 4, :description => "3Matige beperking in activiteiten ten gevolgen van lichamelijk gezondheidsprobleem."
  option :a5, :value => 5, :description => "4Ernstige of volledige incapaciteit als gevolg van lichamelijk gezondheidsprobleem."
  option :a9, :value => 9, :description => "9Geen of onvoldoende informatie voorhanden."
end

question :v_6, :type => :radio do
  title "6. Problemen als gevolg van hallucinaties en waanvoorstellingen"
  description ""
  option :a1, :value => 1, :description => "0Geen aanwijzingen voor hallucinaties of waanvoorstellingen gedurende de afgelopen periode."
  option :a2, :value => 2, :description => "1Enigszins vreemde of excentrieke opvattingen niet in overeenstemming met de culturele normen."
  option :a3, :value => 3, :description => "2Wanen of hallucinaties (bijvoorbeeld stemmen, visioenen) zijn aanwezig, maar vormen weinig hinder voor de cliënt en manifesteren zich niet in bizar gedrag, dus klinisch aantoonbaar maar licht."
  option :a4, :value => 4, :description => "3Duidelijke preoccupatie met wanen of hallucinaties wat veel hinder veroorzaakt en/of zich manifesteert in duidelijk bizar gedrag, dus een matig ernstig klinisch probleem."
  option :a5, :value => 5, :description => "4Geestesgesteldheid en gedrag wordt in ernstige mate en nadelig beïnvloed door wanen of hallucinaties, met een zware uitwerking op de cliënt."
  option :a9, :value => 9, :description => "9Geen of onvoldoende informatie voorhanden."
end

question :v_7, :type => :radio do
  title "7. Problemen met depressieve stemming"
  description ""
  option :a1, :value => 1, :description => "0Geen problemen die samenhangen met een depressieve stemming gedurende de afgelopen periode."
  option :a2, :value => 2, :description => "1Sombere gedachten of kleine veranderingen in stemming."
  option :a3, :value => 3, :description => "2Lichte maar duidelijke depressie met hinder voor de cliënt (bijvoorbeeld schuldgevoelens, verminderd gevoel van eigenwaarde)."
  option :a4, :value => 4, :description => "3Depressie met oneigenlijk zelfverwijt; preoccupatie met schuldgevoelens."
  option :a5, :value => 5, :description => "4Ernstige of zeer ernstige depressie met schuldgevoelens of zelfbeschuldiging."
  option :a9, :value => 9, :description => "9Geen of onvoldoende informatie voorhanden."
end

panel do
  question :v_8, :type => :radio do
    title "8. Overige psychische en gedragsproblemen"
    description ""
    option :a1, :value => 1, :description => "0Geen aanwijzingen voor een van deze problemen gedurende de afgelopen periode."
    option :a2, :value => 2, :description => "1Alleen ondergeschikte problemen."
    option :a3, :value => 3, :description => "2Een probleem is klinisch licht aanwezig (cliënt heeft problemen gedeeltelijk onder controle)."
    option :a4, :value => 4, :description => "3Incidenteel ernstige aanval of hinder met verlies van controle (bijvoorbeeld moet angst opwekkende situaties helemaal vermijden, moet een buurman te hulp roepen). Dus een matig ernstig probleem."
    option :a5, :value => 5, :description => "4Ernstig probleem overheerst de meeste activiteiten."
    option :a9, :value => 9, :description => "9Geen of onvoldoende informatie voorhanden."
  end

  question :v_9, :type => :radio do
    title "Specificeer het type probleem:"
    description ""
    option :a1, :value => 1, :description => "fobie"
    option :a2, :value => 2, :description => "angst"
    option :a3, :value => 3, :description => "dwangmatig"
    option :a4, :value => 4, :description => "gespannenheid"
    option :a5, :value => 5, :description => "dissociatief"
    option :a6, :value => 6, :description => "somatiserend"
    option :a7, :value => 7, :description => "eetproblemen"
    option :a8, :value => 8, :description => "slaapproblemen"
    option :a9, :value => 9, :description => "seksuele problemen"
    option :a10, :value => 10, :description => "overig" do
      question :q12398, :type => :string do
        title "Namelijk"
      end
    end
  end
end

question :v_11, :type => :radio do
  title "9. Problemen met relaties"
  description ""
  option :a1, :value => 1, :description => "0Geen belangrijk probleem van deze aard gedurende de afgelopen periode."
  option :a2, :value => 2, :description => "1Ondergeschikte niet-klinische problemen."
  option :a3, :value => 3, :description => "2Duidelijk probleem in maken of onderhouden van ondersteunende relaties: cliënt klaagt hierover en/of de problemen zijn duidelijk voor anderen."
  option :a4, :value => 4, :description => "3Blijvend belangrijk probleem als gevolg van actief of passief terugtrekken uit sociale relaties en/of als gevolg van relaties waar weinig of geen steun van uit gaat."
  option :a5, :value => 5, :description => "4Ernstig en kommervol sociaal isolement wegens onvermogen tot communiceren met anderen en/of wegens terugtrekken uit sociale relaties."
  option :a9, :value => 9, :description => "9Geen of onvoldoende informatie voorhanden."
end

question :v_14, :type => :radio do
  title "10. Problemen met ADL"
  description ""
  option :a1, :value => 1, :description => "0Geen problemen van deze aard gedurende afgelopen periode; goed in staat op alle gebieden te functioneren."
  option :a2, :value => 2, :description => "1Alleen ondergeschikte problemen (bijvoorbeeld slordig zijn, gedesorganiseerd)."
  option :a3, :value => 3, :description => "2Zelfzorg op peil, maar belangrijk onvermogen tot uitvoeren van één of meerdere van de genoemde complexe vaardigheden."
  option :a4, :value => 4, :description => "3Belangrijk probleem op één of meer gebieden van zelfzorg (eten, wassen, aankleden, naar toilet gaan) en belangrijk onvermogen tot het uitvoeren van meerdere complexe vaardigheden."
  option :a5, :value => 5, :description => "4Ernstige beperkingen op alle of bijna alle gebieden van zelfzorg en complexe vaardigheden."
  option :a9, :value => 9, :description => "9Geen of onvoldoende informatie voorhanden."
end

question :v_15, :type => :radio do
  title "11. Problemen met woonomstandigheden"
  description ""
  option :a1, :value => 1, :description => "0Accommodatie en woonomstandigheden zijn acceptabel; zij dragen ertoe bij om elke beperking gescoord op schaal 10 (problemen met ADL) zo beperkt mogelijk te houden en ondersteunen de zelfredzaamheid."
  option :a2, :value => 2, :description => "1Accommodatie is redelijk acceptabel, al zijn er kleine of voorbijgaande problemen (bijvoorbeeld de locatie is niet ideaal, andere voorkeur, het eten niet lekker vinden, etc)."
  option :a3, :value => 3, :description => "2Belangrijke problemen op één of meerdere gebieden betreffende de accommodatie en/of het beleid (bijvoorbeeld beperkte keus; staf of gezin weten niet goed hoe handicaps te beperken of hoe te helpen bij het toepassen of ontwikkelen van nieuwe of intacte vaardigheden)."
  option :a4, :value => 4, :description => "3Zorgwekkende multipele problemen met betrekking tot de woonomstandigheden (bijvoorbeeld sommige basisvoorzieningen ontbreken); de woonomgeving heeft geen of minimale voorzieningen om de onafhankelijkheid van de cliënt te vergroten."
  option :a5, :value => 5, :description => "4Accommodatie is onacceptabel (bijvoorbeeld basisvoorzieningen ontbreken, dreigende uithuis zetting of dakloosheid of woonomstandigheden zijn anderszins onacceptabel) en verergert de problemen van de cliënt."
  option :a9, :value => 9, :description => "9Geen of onvoldoende informatie voorhanden."
end

question :v_16, :type => :radio do
  title "12. Mogelijkheden voor het gebruiken en verbeteren van vaardigheden: beroepsmatig en vrije tijd"
  description ""
  option :a1, :value => 1, :description => "0De dagelijkse omgeving van cliënt is acceptabel; draagt bij om elke beperking gescoord op schaal 10 (problemen met ADL) zo beperkt mogelijk te houden en ondersteunt de zelfredzaamheid."
  option :a2, :value => 2, :description => "1Ondergeschikte of tijdelijke problemen (bijvoorbeeld verlate betaling door de uitkerende instantie); redelijke voorzieningen zijn beschikbaar, maar niet altijd op het gewenste moment, etc."
  option :a3, :value => 3, :description => "2Beperkte keus in activiteiten; gebrek aan tolerantie (bijvoorbeeld onterecht de toegang geweigerd tot openbare voorzieningen zoals een bibliotheek of badhuis); belemmeringen door het ontbreken van een vaste woon- of verblijfplaats; onvoldoende mantelzorg of professionele zorg; zinvolle dagvoorziening is in principe beschikbaar, maar voor een beperkt aantal uren."
  option :a4, :value => 4, :description => "3Duidelijke deficiëntie in diensten om de beperkingen door bestaande handicaps tot een minimum te beperken; geen mogelijkheden om intacte vaardigheden te benutten of nieuwe vaardigheden toe te voegen; ongeschoolde zorg moeilijk toegankelijk."
  option :a5, :value => 5, :description => "4Gebrek aan enige mogelijkheid tot activiteiten overdag verergert de problemen van de cliënt."
  option :a9, :value => 9, :description => "9Geen of onvoldoende informatie voorhanden."
end
