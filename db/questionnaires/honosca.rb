# HoNOSCA

# Project ID 82970
# Date (GMT) 15-01-2010 09:26:33

key "honosca"
title "HoNOSCA"

abortable

panel do
  title "Instructies bij het invullen van de HoNOS JEUGD"
  text <<-END.gsub(/^ {4}/, '')
    * Scoor de schalen in de volgorde van 1-13, indien nodig gevolgd door de aanvullende schalen 14-15
    * Neem geen informatie op die al bij een vorig item is beoordeeld.
    * Scoor het MEEST ERNSTIGE probleem dat zich heeft voorgedaan gedurende *de afgelopen 2 weken*.
    * Alle schalen hebben de volgende opbouw:
      * 0 = geen probleem
      * 1 = ondergeschikt probleem, vereist geen actie
      * 2 = licht probleem, maar duidelijk aanwezig
      * 3 = matig ernstig probleem
      * 4 = ernstig tot zeer ernstig probleem
    * Gebruik de score 9 wanneer over het betreffende item geen of onvoldoende informatie voorhanden is.

    Klik op 'Volgende vraag' om verder te gaan.
  END
end

panel do
  text "### Sectie A"
  question :v_1, :type => :radio, :required => true do
    title "1. Problemen met storend, antisociaal of agressief gedrag"
    description  <<-END
  *Inclusief:* gedrag dat gepaard gaat met een stoornis, zoals hyperkinesie, depressie, autisme, drugs of alcohol.
  
  *Inclusief:* fysieke of verbale agressie (bijv. duwen, slaan, vandalisme, plagen), of mishandeling of seksueel misbruik van andere kinderen.
  
  *Inclusief:* antisociaal gedrag (bijv. stelen, liegen, bedriegen) of oppositioneel gedrag (bijv. uitdagend gedrag, opstand tegen gezag, of driftbuien).
  
  *Exclusief:* hyperactiviteit, te scoren op schaal 2; spijbelen, te scoren op schaal 13; zelfbeschadiging, te scoren op schaal 3.
  END
    
    option :a1, :value => 0, :description => "0 Geen problemen van deze aard gedurende de beoordeelde periode."
    option :a2, :value => 1, :description => "1 In geringe mate ruziemaken, veeleisend gedrag, overmatige irritatie, liegen, enzovoort."
    option :a3, :value => 2, :description => "2 Licht, maar duidelijk storend of antisociaal gedrag, geringe schade aan eigendommen, of agressie, of uitdagend gedrag."
    option :a4, :value => 3, :description => "3 Matig ernstig agressief of antisociaal gedrag, zoals vechten of voortdurend dreigen, of zeer oppositioneel, of ernstiger vernieling van eigendommen, of matig ernstige delicten."
    option :a5, :value => 4, :description => "4 Storend tijdens bijna alle activiteiten, of ten minsten één ernstige fysieke aanval op anderen of dieren, of ernstige vernieling van eigendommen."
    option :a9, :value => 9, :description => "9 Geen of onvoldoende informatie voorhanden."
  end
end

question :v_2, :type => :radio, :required => true do
  title "2. Problemen met hyperactiviteit, aandacht of concentratie"
  description  <<-END
  *Inclusief:* hyperactief gedrag, ongeacht de oorzaak zoals hyperkinesie, manie, of voortvloeiend uit drugsgebruik.
  
  *Inclusief:* problemen met rusteloosheid, friemelen, gebrek aan aandacht of concentratie vanwege welke oorzaak dan ook, inclusief depressie.
  END
  
  option :a1, :value => 0, :description => "0 Geen problemen van deze aard gedurende de beoordeelde periode."
  option :a2, :value => 1, :description => "1 Enige hyperactiviteit of geringe rusteloosheid, enzovoort."
  option :a3, :value => 2, :description => "2 Lichte maar duidelijke hyperactiviteit en / of aandachtsproblemen, maar deze zijn meestal beheersbaar."
  option :a4, :value => 3, :description => "3 Matig ernstige hyperactiviteit en / of aandachtsproblemen die soms onbeheersbaar zijn."
  option :a5, :value => 4, :description => "4 Ernstige hyperactiviteit en / of aandachtsproblemen die optreden in de meeste activiteiten en bijna nooit beheersbaar zijn."
  option :a9, :value => 9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :v_3, :type => :radio, :required => true do
  title "3. Opzettelijke zelfverwonding"
  description  <<-END
  *Inclusief:* zelfbeschadiging zoals zichzelf slaan en snijden; suïcidepogingen, overdoses, ophanging, verdrinking, enzovoort.
  
  *Exclusief:* krabben, pulken als direct gevolg van een fysieke aandoening, te scoren op schaal 6.
  
  *Exclusief:* onopzettelijke zelfverwonding, bijvoorbeeld vanwege een ernstige leerstoornis of lichamelijke handicap, te scoren op schaal 6;
  ziekte of verwonding als direct gevolg van drugs- of alcoholgebruik, te scoren op schaal 6.
  END
  option :a1, :value => 0, :description => "0 Geen probleem van deze aard tijdens de beoordeelde periode."
  option :a2, :value => 1, :description => "1 Af en toe gedachten over dood, of over zelfbeschadiging die niet leiden tot verwonding. Geen zelfbeschadiging of suïcidale gedachten."
  option :a3, :value => 2, :description => "2 Ongevaarlijke zelfbeschadiging, zoals krassen in polsen, al dan niet gepaard met suïcidale gedachten."
  option :a4, :value => 3, :description => "3 Matig ernstige intentie tot suïcide (inclusief voorbereidende handelingen, bijv. pillen verzamelen) of matige ongevaarlijke zelfbeschadiging (bijv. kleine overdosis)."
  option :a5, :value => 4, :description => "4 Ernstige suïcidepoging (bijv. ernstige overdosis), of ernstige opzettelijke zelfverwonding."
  option :a9, :value => 9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :v_4, :type => :radio, :required => true do
  title "4. Problemen met alcohol, misbruik van (oplos)middelen"
  description  <<-END
  *Inclusief:* problemen met alcohol, misbruik van (oplos)middelen met inachtneming van huidige leeftijd en maatschappelijke normen.
  
  *Exclusief:* agressief / storend gedrag vanwege alcohol- of drugsgebruik, te scoren op schaal 1; lichamelijke ziekte of handicap vanwege alcohol- of drugsgebruik, te scoren op schaal 6.
  END
  option :a1, :value => 0, :description => "0 Geen problemen van deze aard tijdens de beoordeelde periode."
  option :a2, :value => 1, :description => "1 Gering alcohol- of drugsgebruik, binnen de leeftijdsnormen."
  option :a3, :value => 2, :description => "2 Licht excessief alcohol- of drugsgebruik."
  option :a4, :value => 3, :description => "3 Matig ernstige drugs- of alcoholproblemen die significant afwijken van leeftijdsnormen."
  option :a5, :value => 4, :description => "4 Ernstige drugs- of alcoholproblemen die leiden tot afhankelijkheid of beperkingen."
  option :a9, :value => 9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :v_5, :type => :radio, :required => true do
  title "5. Problemen met leer- of taalvaardigheid"
  description  <<-END
  *Inclusief:* problemen met lezen, spellen, wiskunde, spraak of taal, ongeacht het gepaard gaan met een bepaalde stoornis of probleem, zoals een specifiek ontwikkelingsprobleem, of een lichamelijke handicap zoals een gehoorprobleem.
  
  *Inclusief:* verminderde leerprestaties die gepaard gaan met emotionele of gedragsproblemen.
  
  *Exclusief:* een algemeen leerprobleem, tenzij het kind onder het verwachte niveau functioneert.
  END
  option :a1, :value => 0, :description => "0 Geen problemen van deze aard tijdens de beoordeelde periode."
  option :a2, :value => 1, :description => "1 Geringe beperking die niet past binnen het normale ontwikkelingsniveau."
  option :a3, :value => 2, :description => "2 Lichte maar duidelijke beperking met klinische significantie."
  option :a4, :value => 3, :description => "3 Matig ernstige problemen, onder het verwachte niveau vanwege geestelijke leeftijd, eerdere prestaties, of lichamelijke handicap."
  option :a5, :value => 4, :description => "4 Ernstige beperking, ver onder het verwachte niveau vanwege geestelijke leeftijd, eerdere prestaties, of lichamelijke handicap."
  option :a9, :value => 9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :v_6, :type => :radio, :required => true do
  title "6. Problemen vanwege een lichamelijke aandoening of handicap"
  description  <<-END
  *Inclusief:* problemen met een lichamelijke aandoening of handicap die beweging beperken of onmogelijk maken, zien of horen beperken, of anderszins het persoonlijke functioneren belemmeren.
  
  *Inclusief:* bewegingsstoornis, bijwerkingen van medicatie, lichamelijke gevolgen van drugs- of alcoholgebruik, of lichamelijke complicaties bij psychologische stoornissen, zoals ernstig gewichtsverlies.
  
  *Inclusief:* zelfbeschadiging vanwege een ernstige intelligentietekort of lichamelijke handicap, of ten gevolge van zelfbeschadiging zoals hoofdbonken.
  
  *Exclusief:* somatische klachten die geen organische oorzaak hebben, te scoren op schaal 8.
  END
  option :a1, :value => 0, :description => "0 Geen beperking vanwege een probleem met lichamelijke gezondheid tijdens de beoordeelde periode."
  option :a2, :value => 1, :description => "1 Geringe beperking vanwege een gezondheidsprobleem tijdens de periode (bijv. verkoudheid, niet ernstige val, enz.)."
  option :a3, :value => 2, :description => "2 Probleem met lichamelijke gezondheid veroorzaakt lichte maar duidelijke functiebeperking."
  option :a4, :value => 3, :description => "3 Matige beperking in activiteit vanwege probleem met lichamelijke gezondheid."
  option :a5, :value => 4, :description => "4 Volledige of ernstige beperking vanwege problemen met lichamelijke gezondheid."
  option :a9, :value => 9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :v_7, :type => :radio, :required => true do
  title "7. Problemen die gepaard gaan met hallucinaties, wanen of abnormale percepties"
  description  <<-END
  *Inclusief:* hallucinaties, wanen of abnormale waarneming ongeacht diagnose.
  
  *Inclusief:* vreemd en bizar gedrag dat gepaard gaat met hallucinaties en wanen.
  
  *Inclusief:* problemen met andere abnormale waarneming zoals illusies of pseudo-hallucinaties, of waanachtige ideeën zoals een vertekend lichaamsbeeld, achterdochtige of paranoïde gedachten.
  
  *Exclusief:* storend of agressief gedrag dat gepaard gaat met hallucinaties of wanen, te scoren op schaal 1; hyperactief gedrag dat gepaard gaat met hallucinaties of wanen, te scoren op schaal 2.
  END
  option :a1, :value => 0, :description => "0 Geen blijk van abnormale gedachten of waarnemingen tijdens de beoordeelde periode."
  option :a2, :value => 1, :description => "1 Enigszins vreemde of excentrieke opvattingen die niet stroken met culturele waarden."
  option :a3, :value => 2, :description => "2 Abnormale gedachten of waarnemingen doen zich voor (bijv. paranoïde ideeën, illusies of verstoring van het lichaamsbeeld) maar er is weinig lijdensdruk of uiting in bizar gedrag, d.w.z. klinisch aanwezig maar in lichte mate."
  option :a4, :value => 3, :description => "3 Matige preoccupatie met abnormale gedachten, waarnemingen, wanen of hallucinaties die veel lijdensdruk veroorzaken en / of zich uiten in uitgesproken bizar gedrag."
  option :a5, :value => 4, :description => "4 Geestestoestand en gedrag worden ernstig en nadelig beïnvloed door wanen of hallucinaties of abnormale percepties, met ernstige impact op kind / adolescent of anderen."
  option :a9, :value => 9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :v_8, :type => :radio, :required => true do
  title "8. Problemen met niet-organische somatische symptomen"
  description  <<-END
  *Inclusief:* problemen met gastro-enterologische symptomen zoals niet-organisch braken, of cardiovasculaire symptomen, of neurologische symptomen , of niet-organische enuresis, of slaapproblemen, of chronische vermoeidheid. 
  
  *Exclusief:* beweginsstoornissen zoals tics, te scoren op schaal 6; lichamelijke aandoeningen die complicaties opleveren bij niet-organische somatische symptomen, te scoren op schaal 6.
  END
  option :a1, :value => 0, :description => "0 Geen problemen van deze aard tijdens de beoordeelde periode."
  option :a2, :value => 1, :description => "1 Slechts geringe problemen, zoals af en toe urineverlies, geringe slaapproblemen, hoofdpijn of buikpijn zonder organische oorzaak."
  option :a3, :value => 2, :description => "2 Licht maar duidelijk probleem met niet-organische somatische symptomen."
  option :a4, :value => 3, :description => "3 Matig ernstige symptomen die een matige beperking opleveren bij sommige activiteiten."
  option :a5, :value => 4, :description => "4 Zeer ernstige symptomen die aanhouden bij de meeste activiteiten, met grote nadelige invloed op het kind."
  option :a9, :value => 9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :v_11, :type => :radio, :required => true do
  title "9. Emotionele problemen en daarmee verband houdende symptomen"
  description  <<-END
  Scoor alleen het meest ernstige klinische probleem dat niet op voorafgaande schalen is beoordeeld.
  *Inclusief:* depressie, angst, piekeren, fobieën, obsessies of compulsies die hun oorzaak hebben in welke klinische conditie dan ook, inclusief eetstoornissen. 
  
  *Exclusief:* agressief, destructief of hyperactief gedrag, dat wordt toegeschreven aan angsten en fobieën, te scoren op schaal 1.
  
  *Exclusief:* lichamelijke complicaties bij psychologische stoornissen, zoals ernstig gewichtsverlies, te scoren op schaal 6.
  END
  option :a1, :value => 0, :description => "0 Geen aanwijzingen voor dergelijke problemen tijdens de beoordeelde periode."
  option :a2, :value => 1, :description => "1 In geringe mate angstig, somber, of voorbijgaande stemmingswisselingen."
  option :a3, :value => 2, :description => "2 Een licht maar duidelijke emotioneel symptoom is klinisch aanwezig, maar er is geen preoccupatie mee."
  option :a4, :value => 3, :description => "3 Matig ernstige emotionele symptomen die preoccupatie opleveren, intrusief zijn bij sommige activiteiten en ten minste af en toe onbeheersbaar zijn."
  option :a5, :value => 4, :description => "4 Ernstige emotionele symptomen die intrusief zijn bij alle activiteiten en bijna altijd onbeheersbaar zijn."
  option :a9, :value => 9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :v_14, :type => :radio, :required => true do
  title "10. Problemen met relaties met leeftijdgenoten"
  description  <<-END
  *Inclusief:* problemen met schoolgenoten en sociale netwerk. Problemen die gepaard gaan met zich actief of passief terugtrekken uit sociale relaties, of problemen met juist grenzeloos contact leggen / maken, of problemen met het vermogen om bevredigende relaties met leeftijdgenoten aan te gaan.
    
  *Inclusief:* sociale afwijzing ten gevolge van agressief gedrag of pesten.
  
  *Exclusief:* agressief gedrag of pesten, te scoren op schaal 1; problemen met gezin of broers en zussen, te scoren op schaal 12.
  END
  option :a1, :value => 0, :description => "0 Geen significante problemen tijdens de beoordeelde periode."
  option :a2, :value => 1, :description => "1 Voorbijgaande ofwel geringe problemen, af en toe zich sociaal terugtrekken."
  option :a3, :value => 2, :description => "2 Lichte maar duidelijke problemen bij het aangaan of instandhouden van relaties met leeftijdgenoten. De problemen veroorzaken lijdensdruk vanwege zich sociaal terugtrekken, grenzeloosheid in het contact leggen, afgewezen of gepest worden."
  option :a4, :value => 3, :description => "3 Matige problemen vanwege zich actief of passief terugtrekken uit sociale relaties, vanwege juist grenzeloosheid in het contact leggen en / of vanwege relaties die weinig of geen troost of steun bieden, bijv. ten gevolge van ernstig gepest worden."
  option :a5, :value => 4, :description => "4 Ernstige sociale isolatie, geen vrienden vanwege onvermogen om sociaal te communiceren en / of zich terugtrekken uit sociale relaties."
  option :a9, :value => 9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :v_15, :type => :radio, :required => true do
  title "11. Problemen met zelfverzorging en onafhankelijkheid"
  description  <<-END
  Scoor het algehele niveau van functioneren: bijv. problemen met basale zelfverzorgingsactiviteiten zoals eten, wassen, aankleden, toilet maken, alsmede complexe vaardigheden zoals met geld omgaan, zelfstandig reizen, boodschappen doen, enzovoort, met inachtneming van de norm voor de leeftijd en intelligentie van het kind.
  
  *Inclusief:* lage niveaus van functioneren die voortvloeien uit gebrek aan motivatie, stemming of enige andere stoornis.
  
  *Exclusief:* het ontbreken van mogelijkheden om aanwezige vermogens en vaardigheden toe te passen, zoals kan voorkomen in een extreem streng gezin, te scoren op schaal 12: enuresis en encopresis, te scoren op schaal 8.
  END
  option :a1, :value => 0, :description => "0 Geen problemen tijdens de beoordeelde periode; goed vermogen om te functioneren op alle gebieden."
  option :a2, :value => 1, :description => "1 Slechts geringe problemen: bijv. slordig, ongeorganiseerd."
  option :a3, :value => 2, :description => "2 Adequate zelfverzorging, maar duidelijk onvermogen om een of meer complexe vaardigheden uit te oefenen (zie boven)."
  option :a4, :value => 3, :description => "3 Grote problemen op een of meer gebieden van zelfverzorging (eten, wassen, aankleden) of onvermogen om verscheidene complexe vaardigheden uit te oefenen."
  option :a5, :value => 4, :description => "4 Ernstige beperking op alle of bijna alle gebieden van zelfverzorging en / of complexe vaardigheden."
  option :a9, :value => 9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :v_16, :type => :radio, :required => true do
  title "12. Problemen met gezinsleven en relaties"
  description  <<-END
  *Inclusief:* relatieproblemen tussen ouder en kind, en broers en zussen onderling.
  
  *Inclusief:* relaties met pleegouders, maatschappelijk werkers / leerkrachten bij uithuisplaatsing. Zowel relaties thuis als met gescheiden ouders of broers en zussen die elders wonen, moeten worden opgenomen. Persoonlijkheidsproblemen, geestesziekten, huwelijksproblemen van de ouders moeten hier alleen worden gescoord wanneer zij effect hebben op het kind.
  
  *Inclusief:* problemen met seksueel misbruik of mishandeling en emotionele mishandeling (zoals slechte communicatie, ruzies, verbale of fysieke vijandigheid, kritiek en denigrerende opmerkingen, verwaarlozing / afwijzing door de ouders en extreme strengheid).
  
  *Inclusief:* jaloezie van broers / zussen, fysieke mishandeling of seksueel misbruik onder dwang door broer / zus.
  
  *Inclusief:* problemen met verstrengeling en overprotectie.
  
  *Exclusief:* agressief gedrag van kind, te scoren op schaal 1.
  END
  option :a1, :value => 0, :description => "0 Geen problemen tijdens de beoordeelde periode."
  option :a2, :value => 1, :description => "1 Geringe of voorbijgaande problemen."
  option :a3, :value => 2, :description => "2 Licht maar duidelijk probleem, bijv. enkele perioden van verwaarlozing of vijandigheid of verstrengeling of overprotectie."
  option :a4, :value => 3, :description => "3 Matige problemen, bijv. verwaarlozing, mishandeling, vijandigheid. Problemen die gepaard gaan met uiteenvallen van een gezin, wegvallen van verzorger, of reorganisatie."
  option :a5, :value => 4, :description => "4 Ernstige problemen waarbij het kind zich het slachtoffer voelt / is van mishandeld of ernstig verwaarloosd worden door gezin of verzorger."
  option :a9, :value => 9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :v_51, :type => :radio, :required => true do
  title "13. Afwezigheid van school"
  description  <<-END
  *Inclusief:* spijbelen, schoolweigering, afwezigheid of schorsing om welke reden dan ook.
  
  *Inclusief:* schoolgaan naar type school ten tijde van het scoren, bijv. ziekenhuisschool, thuisonderwijs, enzovoort.
  
  Scoor in schoolvakanties de laatste twee weken van de afgelopen lesperiode.
  END
  option :a1, :value => 0, :description => "0 Geen problemen van deze aard tijdens de beoordeelde periode."
  option :a2, :value => 1, :description => "1 Geringe problemen, bijv. te laat bij twee of meer lessen."
  option :a3, :value => 2, :description => "2 Duidelijke maar lichte problemen, bijv. verscheidene lessen gemist vanwege spijbelen of weigeren naar school te gaan."
  option :a4, :value => 3, :description => "3 Aanzienlijke problemen, verscheidene dagen afwezig tijdens de beoordeelde periode."
  option :a5, :value => 4, :description => "4 Ernstige problemen , de meeste of alle dagen afwezig. Enige vorm van schorsing, uitsluiting of van school sturen om welke reden dan ook tijdens de beoordeelde periode."
  option :a9, :value => 9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

panel do
  text <<-END
### Sectie B
  
  Schaal 14 en 15 gaan over problemen voor kind, ouder of verzorger met betrekking tot gebrek aan informatie over, of toegang tot hulpverlening. Dit zijn geen directe maten voor de geestelijke gezondheid van het kind, maar veranderingen hierin kunnen baat voor het kind op de lange termijn opleveren.
  END
end

question :v_52, :type => :radio, :required => true do
  title "14. Problemen met kennis over of begrip van de aard van de problemen van het kind / de adolescent"
  description  <<-END
  *Inclusief:* gebrek aan bruikbare informatie of gebrekkig begrip ter beschikking van kind / adolescent, ouders of verzorgers.
  
  *Inclusief:* gebrek aan uitleg over de diagnose of de oorzaak van het probleem of de prognose.
  END
  option :a1, :value => 0, :description => "0 Geen problemen tijdens de beoordeelde periode. Ouders / verzorgers zijn voldoende geïnformeerd over de problemen van het kind."
  option :a2, :value => 1, :description => "1 Slechts geringe problemen."
  option :a3, :value => 2, :description => "2 Licht maar duidelijk probleem."
  option :a4, :value => 3, :description => "3 Matig ernstige problemen. Ouders / verzorgers hebben zeer weinig of onjuiste kennis over het probleem, wat moeilijkheden veroorzaakt, zoals verwarring of zelfbeschuldiging."
  option :a5, :value => 4, :description => "4 Zeer ernstig probleem. Ouders hebben geen begrip van de aard van de problemen van hun kind."
  option :a9, :value => 9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

question :v_53, :type => :radio, :required => true do
  title "15. Probleem met gebrek aan informatie over hulpverlening of omgaan met de problemen van het kind / de adolescent"
  description  <<-END
  *Inclusief:* gebrek aan bruikbare informatie of gebrekkig begrip ter beschikking van kind / adolescent, ouders of verzorgers.
  
  *Inclusief:* gebrek aan informatie over de meest geschikte manier van hulpverlening aan het kind zoals zorgregelingen, of plaatsing op een school, of opvang, of subsidieaanvragen.
  END
  option :a1, :value => 0, :description => "0 Geen problemen tijdens de beoordeelde periode. De behoefte aan alle hulp die noodzakelijk is wordt onderkend."
  option :a2, :value => 1, :description => "1 Slechts geringe problemen."
  option :a3, :value => 2, :description => "2 Licht maar duidelijk probleem."
  option :a4, :value => 3, :description => "3 Matig ernstige problemen. Ouders / verzorgers hebben weinig informatie gekregen over geschikte hulpverlening, of hulpverleners weten niet wat ze met een kind aanmoeten."
  option :a5, :value => 4, :description => "4 Zeer ernstig probleem. Ouders hebben geen informatie over geschikte hulpverlening, of hulpverleners hebben geen idee wat ze met een kind aanmoeten."
  option :a9, :value => 9, :description => "9 Geen of onvoldoende informatie voorhanden."
end

