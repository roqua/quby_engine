# HoNOS

# Project ID 52663
# Date (GMT) 15-01-2010 09:28:47

key "honos"
title "HoNOS"
description ""

abortable

# TODO We need a DSL method "show_values" of sorts which enables displaying the value of each answer

panel do
  title "Instructies bij het invullen van de HoNOS"
  text <<-END.gsub(/^ {4}/, '')
    * (a)	Scoor elke schaal in de volgorde van 1 - 12.
    * (b)	Gebruik geen informatie die bij een vorig item al is meegenomen, behalve bij item 10 wat een globale score is.
    * (c)	Scoor het MEEST ERNSTIGE probleem dat zich heeft voorgedaan gedurende *de afgelopen 2 weken*.
    * (d)	Alle schalen hebben de volgende opbouw:
      * 0 = geen probleem
      * 1 = ondergeschikt probleem, vereist geen actie
      * 2 = licht probleem, maar duidelijk aanwezig
      * 3 = matig ernstig probleem
      * 4 = ernstig tot zeer ernstig probleem
    * (e)	Gebruik de score 9 wanneer over het betreffende item geen of onvoldoende informatie voorhanden is.

    Klik op 'Volgende' om verder te gaan.
  END
end

question :v_1, :type => :radio, :required => true do
  title "1. Hyperactief, agressief, destructief of geagiteerd gedrag"
  description <<-END
  *Inclusief:* elk zulk gedrag ongeacht de oorzaak (drugs, alcohol, dementie, psychose, depressie, etc.)<br/>
  *Exclusief:*  bizar gedrag dat gescoord wordt bij item 6 (hallucinaties en wanen).
  END

  option :a1, :value => 0, :description => "0 Geen problemen van deze aard gedurende de afgelopen periode."
  option :a2, :value => 1, :description => "1 Geïrriteerdheid, ruzies, rusteloosheid etc, maar vereist geen actie."
  option :a3, :value => 2, :description => "2 Omvat agressieve gebaren, opdringerig of lastig vallen van anderen; bedreigingen of verbale agressie; kleinere schade aan eigendommen (zoals gebroken kopjes of raam); duidelijke hyperactiviteit of agitatie."
  option :a4, :value => 3, :description => "3 Fysiek agressief naar mens of dier; dreigende houding; meer ernstige hyperactiviteit of vernieling van eigendommen."
  option :a5, :value => 4, :description => "4 Minstens één ernstige fysieke aanval op mens of dier; vernielen van eigendommen (bijvoorbeeld brandstichting); ernstige intimidatie of aanstootgevend gedrag."
  option :a9, :value => 9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :v_2, :type => :radio, :required => true do
  title "2. Opzettelijke zelfverwonding"
  description <<-END
  *Exclusief:* zelfverwonding per ongeluk ontstaan (bijvoorbeeld als gevolg van dementie of verstandelijke handicap); het cognitieve probleem hierbij wordt gescoord op schaal 4, de verwonding op schaal 5. <br/>
  *Exclusief:* ziekte of verwonding als direct gevolg van alcohol- of druggebruik worden gescoord op schaal 3 (levercirrose of bijvoorbeeld verwondingen als gevolg van rijden onder invloed worden gescoord op schaal 5).
  END

  option :a1, :value => 0, :description => "0 Geen problemen van deze aard gedurende de afgelopen periode."
  option :a2, :value => 1, :description => "1 Voorbijgaande gedachten over zelfmoord maar gering risico de afgelopen periode; geen zelfverwonding."
  option :a3, :value => 2, :description => "2 Licht risico gedurende de afgelopen periode; omvat ongevaarlijke zelfverwonding (zoals krassen in de pols)."
  option :a4, :value => 3, :description => "3 Matig tot ernstig risico voor opzettelijke zelfverwonding gedurende de afgelopen periode; omvat voorbereidende activiteiten (zoals verzamelen van tabletten)."
  option :a5, :value => 4, :description => "4 Ernstige suïcidepoging en/of ernstige opzettelijke zelfverwonding de afgelopen periode."
  option :a9, :value => 9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :v_3, :type => :radio, :required => true do
  title "3. Problematisch alcohol- of druggebruik"
  description <<-END
  *Exclusief:* agressief of destructief gedrag als gevolg van alcohol of druggebruik. Dat wordt gescoord op schaal 1.<br/>
  *Exclusief:* lichamelijke ziekte of handicap als gevolg van alcohol- of druggebruik. Dat wordt gescoord op schaal 5
  END

  option :a1, :value => 0, :description => "0 Geen problemen van deze aard gedurende de afgelopen periode."
  option :a2, :value => 1, :description => "1 Enig overmatig gebruik, maar binnen de sociale norm."
  option :a3, :value => 2, :description => "2 Verlies van controle over alcohol- of druggebruik, maar niet ernstig verslaafd."
  option :a4, :value => 3, :description => "3 Duidelijke zucht naar of afhankelijkheid van alcohol of drugs met frequent controleverlies; risico's nemen onder invloed."
  option :a5, :value => 4, :description => "4 Incapabel door alcohol- of drugs problemen."
  option :a9, :value => 9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :v_4, :type => :radio, :required => true do
  title "4. Cognitieve problemen"
  description <<-END
  *Inclusief:* problemen met geheugen, ori&euml;ntatie en begripsvermogen passend bij enige stoornis: leerstoornis, dementie, schizofrenie, etc.<br/>
  *Exclusief:* tijdelijke problemen als gevolg van alcohol/druggebruik (bijvoorbeeld een kater) die gescoord worden op schaal 3 (problematisch alcohol- of druggebruik).
  END

  option :a1, :value => 0, :description => "0 Geen problemen van deze aard gedurende de afgelopen periode."
  option :a2, :value => 1, :description => "1 Ondergeschikte problemen met geheugen en begripsvermogen (bijvoorbeeld zo nu en dan vergeten van namen)."
  option :a3, :value => 2, :description => "2 Licht, maar duidelijk aanwezige problemen (bijvoorbeeld verdwaald in een bekende omgeving, niet herkennen van een bekende); soms in verwarring bij het nemen van simpele beslissingen."
  option :a4, :value => 3, :description => "3 Duidelijke desoriëntatie in tijd, plaats of persoon; in de war gebracht door dagelijkse gebeurtenissen; zo nu en dan incoherente spraak; vertraagd denken."
  option :a5, :value => 4, :description => "4 Ernstige desoriëntatie (bijvoorbeeld niet herkennen van familie); gevaar voor ongelukken; onbegrijpelijk taalgebruik; verlaagd bewustzijn of stupor."
  option :a9, :value => 9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :v_5, :type => :radio, :required => true do
  title "5. Lichamelijke problemen of handicaps"
  description <<-END
  *Inclusief:* ziekte of handicap van elke oorsprong die mobiliteits-beperkingen geven, het zicht of gehoor aantasten, dan wel anderszins interfereren met het persoonlijk functioneren.<br/>
  *Inclusief:* bijwerkingen van medicatie; effecten van drug- of alcoholgebruik; handicaps als gevolg van ongevallen of zelfverwonding voortkomend uit cognitieve problemen, rijden onder invloed, etc.<br/>
  *Exclusief:* psychische problemen of gedrags-problemen die gescoord worden op schaal 4 (cognitieve problemen).
  END
  
  option :a1, :value => 0, :description => "0 Geen lichamelijke gezondheidsproblemen gedurende de afgelopen periode."
  option :a2, :value => 1, :description => "1 Ondergeschikte gezondheidsproblemen gedurende de afgelopen periode (bijvoorbeeld verkoudheid, niet ernstige val)."
  option :a3, :value => 2, :description => "2 Lichamelijke gezondheidsproblemen leiden tot lichte beperking in mobiliteit en activi-teiten."
  option :a4, :value => 3, :description => "3 Matige beperking in activiteiten ten gevolgen van lichamelijk gezondheidsprobleem."
  option :a5, :value => 4, :description => "4 Ernstige of volledige incapaciteit als gevolg van lichamelijk gezondheidsprobleem."
  option :a9, :value => 9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :v_6, :type => :radio, :required => true do
  title "6. Problemen als gevolg van hallucinaties en waanvoorstellingen"
  description <<-END
  *Inclusief:* hallucinaties en waanvoorstellingen ongeacht de diagnose.<br/>
  *Inclusief:* vreemd en bizar gedrag geassocieerd met hallucinaties of waanvoorstellingen.<br/>
  *Exclusief:* agressief, destructief of hyperactief gedrag dat voortkomt uit hallucinaties of wanen en dat gescoord wordt op schaal 1 (hyperactief en agressief gedrag).
  END

  option :a1, :value => 0, :description => "0 Geen aanwijzingen voor hallucinaties of waanvoorstellingen gedurende de afgelopen periode."
  option :a2, :value => 1, :description => "1 Enigszins vreemde of excentrieke opvattingen niet in overeenstemming met de culturele normen."
  option :a3, :value => 2, :description => "2 Wanen of hallucinaties (bijvoorbeeld stemmen, visioenen) zijn aanwezig, maar vormen weinig hinder voor de cliënt en manifesteren zich niet in bizar gedrag, dus klinisch aantoonbaar maar licht."
  option :a4, :value => 3, :description => "3 Duidelijke preoccupatie met wanen of hallucinaties wat veel hinder veroorzaakt en/of zich manifesteert in duidelijk bizar gedrag, dus een matig ernstig klinisch probleem."
  option :a5, :value => 4, :description => "4 Geestesgesteldheid en gedrag wordt in ernstige mate en nadelig beïnvloed door wanen of hallucinaties, met een zware uitwerking op de cliënt."
  option :a9, :value => 9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :v_7, :type => :radio, :required => true do
  title "7. Problemen met depressieve stemming"
  description <<-END
  *Exclusief:* hyperactiviteit of geagiteerd gedrag. Dat wordt gescoord op schaal 1.<br/>
  *Exclusief:* su&iuml;cidegedachten of pogingen. Die worden gescoord op schaal 2.<br/>
  *Exclusief:* waanvoorstellingen of hallucinaties. Die worden gescoord op schaal 6.
  END

  option :a1, :value => 0, :description => "0 Geen problemen die samenhangen met een depressieve stemming gedurende de afgelopen periode."
  option :a2, :value => 1, :description => "1 Sombere gedachten of kleine veranderingen in stemming."
  option :a3, :value => 2, :description => "2 Lichte maar duidelijke depressie met hinder voor de cliënt (bijvoorbeeld schuldgevoelens, verminderd gevoel van eigenwaarde)."
  option :a4, :value => 3, :description => "3 Depressie met oneigenlijk zelfverwijt; preoccupatie met schuldgevoelens."
  option :a5, :value => 4, :description => "4 Ernstige of zeer ernstige depressie met schuldgevoelens of zelfbeschuldiging."
  option :a9, :value => 9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

panel do
  question :v_8, :type => :radio, :required => true do
    title "8. Overige psychische en gedragsproblemen"
    description "Scoor alleen het meest ernstige klinische probleem niet vallend onder item 6 (hallucinaties en wanen) en item 7 (depressieve stemming)."

    option :a1, :value => 0, :description => "0 Geen aanwijzingen voor een van deze problemen gedurende de afgelopen periode."
    option :a2, :value => 1, :description => "1 Alleen ondergeschikte problemen."
    option :a3, :value => 2, :description => "2 Een probleem is klinisch licht aanwezig (cliënt heeft problemen gedeeltelijk onder controle)."
    option :a4, :value => 3, :description => "3 Incidenteel ernstige aanval of hinder met verlies van controle (bijvoorbeeld moet angst opwekkende situaties helemaal vermijden, moet een buurman te hulp roepen). Dus een matig ernstig probleem."
    option :a5, :value => 4, :description => "4 Ernstig probleem overheerst de meeste activiteiten."
    option :a9, :value => 9, :description => "9 Geen of onvoldoende informatie voorhanden."
  end

  question :v_9, :type => :radio do
    title "Specificeer het type probleem:"

    # TODO Check values for this set of options
    option :a1, :value => 0, :description => "fobie"
    option :a2, :value => 1, :description => "angst"
    option :a3, :value => 2, :description => "dwangmatig"
    option :a4, :value => 3, :description => "gespannenheid"
    option :a5, :value => 4, :description => "dissociatief"
    option :a6, :value => 5, :description => "somatiserend"
    option :a7, :value => 6, :description => "eetproblemen"
    option :a8, :value => 7, :description => "slaapproblemen"
    option :a9, :value => 8, :description => "seksuele problemen"
    option :a10, :value => 10, :description => "overig" do
      question :v_10, :type => :string do
        title "Namelijk"
      end
    end
  end
end

question :v_11, :type => :radio, :required => true do
  title "9. Problemen met relaties"
  description "Scoor het meest ernstige probleem van de cli&euml;nt dat samenhangt met actief of passief terugtrekken uit sociale relaties en/of dat samenhangt met niet-ondersteunende, destructieve of zelfvernietigende relaties."
  option :a1, :value => 0, :description => "0 Geen belangrijk probleem van deze aard gedurende de afgelopen periode."
  option :a2, :value => 1, :description => "1 Ondergeschikte niet-klinische problemen."
  option :a3, :value => 2, :description => "2 Duidelijk probleem in maken of onderhouden van ondersteunende relaties: cliënt klaagt hierover en/of de problemen zijn duidelijk voor anderen."
  option :a4, :value => 3, :description => "3 Blijvend belangrijk probleem als gevolg van actief of passief terugtrekken uit sociale relaties en/of als gevolg van relaties waar weinig of geen steun van uit gaat."
  option :a5, :value => 4, :description => "4 Ernstig en kommervol sociaal isolement wegens onvermogen tot communiceren met anderen en/of wegens terugtrekken uit sociale relaties."
  option :a9, :value => 9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :v_14, :type => :radio, :required => true do
  title "10. Problemen met ADL"
  description <<-END
  Scoor het totale ADL niveau (bijvoorbeeld problemen met basale zelfzorgactiviteiten zoals eten, wassen, aankleden, naar het toilet gaan; ook complexe vaardigheden als budgetteren, regelen van woonruimte, werk en vrije tijd, mobiliteit en gebruik van openbaar vervoer, boodschappen doen, zelfontplooiing, etc.).

  *Inclusief:* gebrek aan motivatie om mogelijkheden te gebruiken die de zelfredzaamheid kunnen vergroten, want dit draagt bij aan een lager totaal ADL niveau.<br/>
  *Exclusief:* gebrek aan mogelijkheden om intacte bekwaamheden en vaardigheden uit te oefenen. Dit wordt gescoord bij schaal 11 en 12.
  END

  option :a1, :value => 0, :description => "0 Geen problemen van deze aard gedurende afgelopen periode; goed in staat op alle gebieden te functioneren."
  option :a2, :value => 1, :description => "1 Alleen ondergeschikte problemen (bijvoorbeeld slordig zijn, gedesorganiseerd)."
  option :a3, :value => 2, :description => "2 Zelfzorg op peil, maar belangrijk onvermogen tot uitvoeren van één of meerdere van de genoemde complexe vaardigheden."
  option :a4, :value => 3, :description => "3 Belangrijk probleem op één of meer gebieden van zelfzorg (eten, wassen, aankleden, naar toilet gaan) en belangrijk onvermogen tot het uitvoeren van meerdere complexe vaardigheden."
  option :a5, :value => 4, :description => "4 Ernstige beperkingen op alle of bijna alle gebieden van zelfzorg en complexe vaardigheden."
  option :a9, :value => 9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :v_15, :type => :radio, :required => true do
  title "11. Problemen met woonomstandigheden"
  description <<-END
  Scoor de globale ernst van problemen in de kwaliteit van de woonomstandigheden en het dagelijks huishouden. Is aan de basis behoeften voldaan (verwarming, licht, hygi&euml;ne)? Zo ja, is er hulp bij het omgaan met eventuele beperkingen en zijn er mogelijkheden om aanwezige vaardigheden toe te kunnen passen en nieuwe vaardigheden te kunnen ontwikkelen?<br/>
  *Exclusief:* het niveau van functioneren; dat wordt gescoord op schaal 10 (problemen met ADL).<br/>
  N.B. Scoor de gebruikelijke woonomstandigheden van de cliënt.
  END

  option :a1, :value => 0, :description => "0 Accommodatie en woonomstandigheden zijn acceptabel; zij dragen ertoe bij om elke beperking gescoord op schaal 10 (problemen met ADL) zo beperkt mogelijk te houden en ondersteunen de zelfredzaamheid."
  option :a2, :value => 1, :description => "1 Accommodatie is redelijk acceptabel, al zijn er kleine of voorbijgaande problemen (bijvoorbeeld de locatie is niet ideaal, andere voorkeur, het eten niet lekker vinden, etc)."
  option :a3, :value => 2, :description => "2 Belangrijke problemen op één of meerdere gebieden betreffende de accommodatie en/of het beleid (bijvoorbeeld beperkte keus; staf of gezin weten niet goed hoe handicaps te beperken of hoe te helpen bij het toepassen of ontwikkelen van nieuwe of intacte vaardigheden)."
  option :a4, :value => 3, :description => "3 Zorgwekkende multipele problemen met betrekking tot de woonomstandigheden (bijvoorbeeld sommige basisvoorzieningen ontbreken); de woonomgeving heeft geen of minimale voorzieningen om de onafhankelijkheid van de cliënt te vergroten."
  option :a5, :value => 4, :description => "4 Accommodatie is onacceptabel (bijvoorbeeld basisvoorzieningen ontbreken, dreigende uithuis zetting of dakloosheid of woonomstandigheden zijn anderszins onacceptabel) en verergert de problemen van de cliënt."
  option :a9, :value => 9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :v_16, :type => :radio, :required => true do
  title "12. Mogelijkheden voor het gebruiken en verbeteren van vaardigheden: beroepsmatig en vrije tijd"
  description <<-END
  Scoor de problemen in de kwaliteit van de dagelijkse omgeving van de cli&euml;nt. Is er hulp bij het omgaan met beperkingen, zijn er mogelijkheden tot behouden en vergroten van vaardigheden en activiteiten op gebied van werk en vrije tijd. Let op zaken als stigma, gebrek aan gekwalificeerd personeel, toegang tot voorzieningen (bijvoorbeeld bezettingsgraad en uitrusting van dagcentra, werkplaatsen, verenigingen).<br/>

  *Exclusief:* het niveau van functioneren zelf. Dat wordt gescoord op schaal 10 (problemen met ADL).<br/>
  N.B. Scoor de gebruikelijke situatie van de cliënt (wanneer een cliënt is opgenomen, scoor de situatie van voor de opname).
  END

  option :a1, :value => 0, :description => "0 De dagelijkse omgeving van cliënt is acceptabel; draagt bij om elke beperking gescoord op schaal 10 (problemen met ADL) zo beperkt mogelijk te houden en ondersteunt de zelfredzaamheid."
  option :a2, :value => 1, :description => "1 Ondergeschikte of tijdelijke problemen (bijvoorbeeld verlate betaling door de uitkerende instantie); redelijke voorzieningen zijn beschikbaar, maar niet altijd op het gewenste moment, etc."
  option :a3, :value => 2, :description => "2 Beperkte keus in activiteiten; gebrek aan tolerantie (bijvoorbeeld onterecht de toegang geweigerd tot openbare voorzieningen zoals een bibliotheek of badhuis); belemmeringen door het ontbreken van een vaste woon- of verblijfplaats; onvoldoende mantelzorg of professionele zorg; zinvolle dagvoorziening is in principe beschikbaar, maar voor een beperkt aantal uren."
  option :a4, :value => 3, :description => "3 Duidelijke deficiëntie in diensten om de beperkingen door bestaande handicaps tot een minimum te beperken; geen mogelijkheden om intacte vaardigheden te benutten of nieuwe vaardigheden toe te voegen; ongeschoolde zorg moeilijk toegankelijk."
  option :a5, :value => 4, :description => "4 Gebrek aan enige mogelijkheid tot activiteiten overdag verergert de problemen van de cliënt."
  option :a9, :value => 9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

end_panel
