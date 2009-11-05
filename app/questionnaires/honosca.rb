# -*- coding: utf-8 -*-
load File.join(RAILS_ROOT, "lib/quby/init.rb")

Quby::Questionnaires.define(:honosca) do

  # Sectie A

  question :q00, :type => :open do
    title "Wat is uw naam"
  end
  
  question :q01, :type => :radio do
    title "Problemen met storend, antisociaal of agressief gedrag"
    description "<strong>Inclusief:</strong> gedrag dat gepaard gaat met een stoornis, zoals hyperkinesie, depressie, autisme, drugs of alcohol.<br/>
                 <strong>Inclusief:</strong> fysieke of verbale agressie (bijv. duwen, slaan, vandalisme, plagen), of mishandeling of seksueel misbruik van andere kinderen.<br/>
                 <strong>Inclusief:</strong> antisociaal gedrag (bijv. stelen, liegen, bedriegen) of oppositioneel gedrag (bijv. uitdagend gedrag, opstand tegen gezag, of driftbuien).<br/>
                 <strong>Exclusief:</strong> hyperactiviteit, te scoren op schaal 2; spijbelen, te scoren op schaal 13; zelfbeschadiging, te scoren op schaal 3."

    option :q01a00, :value => 0, :description => "Geen problemen van deze aard gedurende de beoordeelde periode"
    option :q01a01, :value => 1, :description => "In geringe mate ruziemaken, veeleisend gedrag, overmatige irritatie, liegen, enzovoort."
    option :q01a02, :value => 2, :description => "Licht, maar duidelijk storend of antisociaal gedrag, geringe schade aan eigendommen, of agressie, of uitdagend gedrag."
    option :q01a03, :value => 3, :description => "Matig ernstig agressief of antisociaal gedrag, zoals vechten of voortdurend dreigen, of zeer oppositioneel, of ernstiger vernieling van eigendommen, of matig ernstige delicten."
    option :q01a04, :value => 4, :description => "Storend tijdens bijna alle activiteiten, of ten minsten één ernstige fysieke aanval op anderen of dieren, of ernstige vernieling van eigendommen."
    option :q01a09, :value => 9, :description => "Geen of onvoldoende informatie voorhanden."
  end

  question :q02, :type => :radio do
    title "Problemen met hyperactiviteit, aandacht of concentratie"
    description "<strong>Inclusief:</strong> hyperactief gedrag, ongeacht de oorzaak zoals hyperkinesie, manie, of voortvloeiend uit drugsgebruik.<br/>
                 <strong>Inclusief:</strong> problemen met rusteloosheid, friemelen, gebrek aan aandacht of concentratie vanwege welke oorzaak dan ook, inclusief depressie."

    option :q02a00, :value => 0, :description => "Geen problemen van deze aard gedurende de beoordeelde periode"
    option :q02a01, :value => 1, :description => "Enige hyperactiviteit of geringe rusteloosheid, enzovoort."
    option :q02a02, :value => 2, :description => "Lichte maar duidelijke hyperactiviteit en / of aandachtsproblemen, maar deze zijn meestal beheersbaar."
    option :q02a03, :value => 3, :description => "Matig ernstige hyperactiviteit en / of aandachtsproblemen die soms onbeheersbaar zijn."
    option :q02a04, :value => 4, :description => "Ernstige hyperactiviteit en / of aandachtsproblemen die optreden in de meeste activiteiten en bijna nooit beheersbaar zijn."
    option :q02a09, :value => 9, :description => "Geen of onvoldoende informatie voorhanden."
  end

  question :q03, :type => :radio do
    title "Opzettelijke zelfverwonding"
    description "<strong>Inclusief:</strong> zelfbeschadiging zoals zichzelf slaan en snijden; suïcidepogingen, overdoses, ophanging, verdrinking, enzovoort.<br/>
                 <strong>Exclusief:</strong> krabben, pulken als direct gevolg van een fysieke aandoening, te scoren op schaal 6.<br/>
                 <strong>Exclusief:</strong> onopzettelijke zelfverwonding, bijvoorbeeld vanwege een ernstige leerstoornis of lichamelijke handicap, te scoren op schaal 6; ziekte of verwonding als direct gevolg van drugs- of alcoholgebruik, te scoren op schaal 6."
                   
    option :q03a00, :value => 0, :description => "Geen problemen van deze aard gedurende de beoordeelde periode"
    option :q03a01, :value => 1, :description => "Af en toe gedachten over dood, of over zelfbeschadiging die niet leiden tot verwonding. Geen zelfbeschadiging of suïcidale gedachten."
    option :q03a02, :value => 2, :description => "Ongevaarlijke zelfbeschadiging, zoals krassen in polsen, al dan niet gepaard met suïcidale gedachten."
    option :q03a03, :value => 3, :description => "Matig ernstige intentie tot suïcide (inclusief voorbereidende handelingen, bijv. pillen verzamelen) of matige ongevaarlijke zelfbeschadiging (bijv. kleine overdosis)."
    option :q03a04, :value => 4, :description => "Ernstige suïcidepoging (bijv. ernstige overdosis), of ernstige opzettelijke zelfverwonding."
    option :q03a09, :value => 9, :description => "Geen of onvoldoende informatie voorhanden."
  end

  question :q04, :type => :radio do
    title "Problemen met alcohol, misbruik van (oplos)middelen"
    description "<strong>Inclusief:</strong> problemen met alcohol, misbruik van (oplos)middelen met inachtneming van huidige leeftijd en maatschappelijke normen.
                 <strong>Exclusief:</strong> agressief / storend gedrag vanwege alcohol- of drugsgebruik, te scoren op schaal 1; lichamelijke ziekte of handicap vanwege alcohol- of drugsgebruik, te scoren op schaal 6."
                   
    option :q04a00, :value => 0, :description => "Geen problemen van deze aard gedurende de beoordeelde periode"
    option :q04a01, :value => 1, :description => "Gering alcohol- of drugsgebruik, binnen de leeftijdsnormen."
    option :q04a02, :value => 2, :description => "Licht excessief alcohol- of drugsgebruik."
    option :q04a03, :value => 3, :description => "Matig ernstige drugs- of alcoholproblemen die significant afwijken van leeftijdsnormen."
    option :q04a04, :value => 4, :description => "Ernstige drugs- of alcoholproblemen die leiden tot afhankelijkheid of beperkingen."
    option :q04a09, :value => 9, :description => "Geen of onvoldoende informatie voorhanden."
  end

  question :q05, :type => :radio do
    title "Problemen met leer- of taalvaardigheid"
    description "<strong>Inclusief:</strong> problemen met lezen, spellen, wiskunde, spraak of taal, ongeacht het gepaard gaan met een bepaalde stoornis of probleem, zoals een specifiek ontwikkelingsprobleem, of een lichamelijke handicap zoals een gehoorprobleem.
                 <strong>Inclusief:</strong> verminderde leerprestaties die gepaard gaan met emotionele of gedragsproblemen.
                 <strong>Exclusief:</strong> tijdelijke problemen die uitsluitend voortvloeien uit gebrekkig onderwijs.
                 <strong>Exclusief:</strong> een algemeen leerprobleem, tenzij het kind onder het verwachte niveau functioneert."
                   
    option :q05a00, :value => 0, :description => "Geen problemen van deze aard gedurende de beoordeelde periode"
    option :q05a01, :value => 1, :description => "Geringe beperking die niet past binnen het normale ontwikkelingsniveau."
    option :q05a02, :value => 2, :description => "Lichte maar duidelijke beperking met klinische significantie."
    option :q05a03, :value => 3, :description => "Matig ernstige problemen, onder het verwachte niveau vanwege geestelijke leeftijd, eerdere prestaties, of lichamelijke handicap."
    option :q05a04, :value => 4, :description => "Ernstige beperking, ver onder het verwachte niveau vanwege geestelijke leeftijd, eerdere prestaties, of lichamelijke handicap."
    option :q05a09, :value => 9, :description => "Geen of onvoldoende informatie voorhanden."
  end

  question :q06, :type => :radio do
    title "Problemen vanwege een lichamelijke aandoening of handicap"
    description "<strong>Inclusief:</strong> problemen met een lichamelijke aandoening of handicap die beweging beperken of onmogelijk maken, zien of horen beperken, of anderszins het persoonlijke functioneren belemmeren.
                 <strong>Inclusief:</strong> bewegingsstoornis, bijwerkingen van medicatie, lichamelijke gevolgen van drugs- of alcoholgebruik, of lichamelijke complicaties bij psychologische stoornissen, zoals ernstig gewichtsverlies.
                 <strong>Inclusief:</strong> zelfbeschadiging vanwege een ernstige intelligentietekort of lichamelijke handicap, of ten gevolge van zelfbeschadiging zoals hoofdbonken.
                 <strong>Exclusief:</strong> somatische klachten die geen organische oorzaak hebben, te scoren op schaal 8."
                   
    option :q06a00, :value => 0, :description => "Geen beperking vanwege een probleem met lichamelijke gezondheid tijdens de beoordeelde periode."
    option :q06a01, :value => 1, :description => "Geringe beperking vanwege een gezondheidsprobleem tijdens de periode (bijv. verkoudheid, niet ernstige val, enz.)."
    option :q06a02, :value => 2, :description => "Probleem met lichamelijke gezondheid veroorzaakt lichte maar duidelijke functiebeperking."
    option :q06a03, :value => 3, :description => "Matige beperking in activiteit vanwege probleem met lichamelijke gezondheid."
    option :q06a04, :value => 4, :description => "Volledige of ernstige beperking vanwege problemen met lichamelijke gezondheid."
    option :q06a09, :value => 9, :description => "Geen of onvoldoende informatie voorhanden."
  end

  question :q07, :type => :radio do
    title "Problemen die gepaard gaan met hallucinaties, wanen of abnormale percepties"
    description "<strong>Inclusief:</strong> hallucinaties, wanen of abnormale waarneming ongeacht diagnose.
                 <strong>Inclusief:</strong> vreemd en bizar gedrag dat gepaard gaat met hallucinaties en wanen.
                 <strong>Inclusief:</strong> problemen met andere abnormale waarneming zoals illusies of pseudo-hallucinaties, of waanachtige ideeën zoals een vertekend lichaamsbeeld, achterdochtige of paranoïde gedachten.
                 <strong>Exclusief:</strong> storend of agressief gedrag dat gepaard gaat met hallucinaties of wanen, te scoren op schaal 1; hyperactief gedrag dat gepaard gaat met hallucinaties of wanen, te scoren op schaal 2."
                   
    option :q07a00, :value => 0, :description => "Geen blijk van abnormale gedachten of waarnemingen tijdens de beoordeelde periode."
    option :q07a01, :value => 1, :description => "Enigszins vreemde of excentrieke opvattingen die niet stroken met culturele waarden."
    option :q07a02, :value => 2, :description => "Abnormale gedachten of waarnemingen doen zich voor (bijv. paranoïde ideeën, illusies of verstoring van het lichaamsbeeld) maar er is weinig lijdensdruk of uiting in bizar gedrag, d.w.z. klinisch aanwezig maar in lichte mate."
    option :q07a03, :value => 3, :description => "Matige preoccupatie met abnormale gedachten, waarnemingen, wanen of hallucinaties die veel lijdensdruk veroorzaken en / of zich uiten in uitgesproken bizar gedrag."
    option :q07a04, :value => 4, :description => "Geestestoestand en gedrag worden ernstig en nadelig beïnvloed door wanen of hallucinaties of abnormale percepties, met ernstige impact op kind / adolescent of anderen."
    option :q07a09, :value => 9, :description => "Geen of onvoldoende informatie voorhanden."
  end

  question :q08, :type => :radio do
    title "Problemen met niet-organische somatische symptomen"
    description "<strong>Inclusief:</strong> problemen met gastro-enterologische symptomen zoals niet-organisch braken, of cardiovasculaire symptomen, of neurologische symptomen , of niet-organische enuresis, of slaapproblemen, of chronische vermoeidheid.
                 <strong>Exclusief:</strong> beweginsstoornissen zoals tics, te scoren op schaal 6; lichamelijke aandoeningen die complicaties opleveren bij niet-organische somatische symptomen, te scoren op schaal 6."
                   
    option :q08a00, :value => 0, :description => "Geen problemen van deze aard gedurende de beoordeelde periode"
    option :q08a01, :value => 1, :description => "Slechts geringe problemen, zoals af en toe urineverlies, geringe slaapproblemen, hoofdpijn of buikpijn zonder organische oorzaak."
    option :q08a02, :value => 2, :description => "Licht maar duidelijk probleem met niet-organische somatische symptomen."
    option :q08a03, :value => 3, :description => "Matig ernstige symptomen die een matige beperking opleveren bij sommige activiteiten."
    option :q08a04, :value => 4, :description => "Zeer ernstige symptomen die aanhouden bij de meeste activiteiten, met grote nadelige invloed op het kind."
    option :q08a09, :value => 9, :description => "Geen of onvoldoende informatie voorhanden."
  end

  question :q09, :type => :radio do
    title "Emotionele problemen en daarmee verband houdende symptomen"
    description "Scoor alleen het meest ernstige klinische probleem dat niet op voorafgaande schalen is beoordeeld.
                 <strong>Inclusief:</strong> depressie, angst, piekeren, fobieën, obsessies of compulsies die hun oorzaak hebben in welke klinische conditie dan ook, inclusief eetstoornissen.
                 <strong>Exclusief:</strong> agressief, destructief of hyperactief gedrag, dat wordt toegeschreven aan angsten en fobieën, te scoren op schaal 1.
                 <strong>Exclusief:</strong> lichamelijke complicaties bij psychologische stoornissen, zoals ernstig gewichtsverlies, te scoren op schaal 6."
                   
    option :q09a00, :value => 0, :description => "Geen aanwijzingen voor dergelijke problemen tijdens de beoordeelde periode."
    option :q09a01, :value => 1, :description => "In geringe mate angstig, somber, of voorbijgaande stemmingswisselingen."
    option :q09a02, :value => 2, :description => "Een licht maar duidelijke emotioneel symptoom is klinisch aanwezig, maar er is geen preoccupatie mee."
    option :q09a03, :value => 3, :description => "Matig ernstige emotionele symptomen die preoccupatie opleveren, intrusief zijn bij sommige activiteiten en ten minste af en toe onbeheersbaar zijn."
    option :q09a04, :value => 4, :description => "Ernstige emotionele symptomen die intrusief zijn bij alle activiteiten en bijna altijd onbeheersbaar zijn."
    option :q09a09, :value => 9, :description => "Geen of onvoldoende informatie voorhanden."
  end

  question :q10, :type => :radio do
    title "Problemen met relaties met leeftijdgenoten"
    description "<strong>Inclusief:</strong> problemen met schoolgenoten en sociale netwerk. Problemen die gepaard gaan met zich actief of passief terugtrekken uit sociale relaties, of problemen met juist grenzeloos contact leggen / maken, of problemen met het vermogen om bevredigende relaties met leeftijdgenoten aan te gaan.
                 <strong>Inclusief:</strong> sociale afwijzing ten gevolge van agressief gedrag of pesten.
                 <strong>Exclusief:</strong> agressief gedrag of pesten, te scoren op schaal 1; problemen met gezin of broers en zussen, te scoren op schaal 12."
                   
    option :q10a00, :value => 0, :description => "Geen significante problemen tijdens de beoordeelde periode."
    option :q10a01, :value => 1, :description => "Voorbijgaande ofwel geringe problemen, af en toe zich sociaal terugtrekken."
    option :q10a02, :value => 2, :description => "Lichte maar duidelijke problemen bij het aangaan of instandhouden van relaties met leeftijdgenoten. De problemen veroorzaken lijdensdruk vanwege zich sociaal terugtrekken, grenzeloosheid in het contact leggen, afgewezen of gepest worden."
    option :q10a03, :value => 3, :description => "Matige problemen vanwege zich actief of passief terugtrekken uit sociale relaties, vanwege juist grenzeloosheid in het contact leggen en / of vanwege relaties die weinig of geen troost of steun bieden, bijv. ten gevolge van ernstig gepest worden."
    option :q10a04, :value => 4, :description => "Ernstige sociale isolatie, geen vrienden vanwege onvermogen om sociaal te communiceren en / of zich terugtrekken uit sociale relaties."
    option :q10a09, :value => 9, :description => "Geen of onvoldoende informatie voorhanden."
  end

  question :q11, :type => :radio do
    title "Problemen met zelfverzorging en onafhankelijkheid"
    description "Scoor het algehele niveau van functioneren: bijv. problemen met basale zelfverzorgingsactiviteiten zoals eten, wassen, aankleden, toilet maken, alsmede complexe vaardigheden zoals met geld omgaan, zelfstandig reizen, boodschappen doen, enzovoort, met inachtneming van de norm voor de leeftijd en intelligentie van het kind.
                 <strong>Inclusief:</strong> lage niveaus van functioneren die voortvloeien uit gebrek aan motivatie, stemming of enige andere stoornis.
                 <strong>Exclusief:</strong> het ontbreken van mogelijkheden om aanwezige vermogens en vaardigheden toe te passen, zoals kan voorkomen in een extreem streng gezin, te scoren op schaal 12: enuresis en encopresis, te scoren op schaal 8."
                   
    option :q11a00, :value => 0, :description => "Geen problemen tijdens de beoordeelde periode; goed vermogen om te functioneren op alle gebieden."
    option :q11a01, :value => 1, :description => "Slechts geringe problemen: bijv. slordig, ongeorganiseerd."
    option :q11a02, :value => 2, :description => "Adequate zelfverzorging, maar duidelijk onvermogen om een of meer complexe vaardigheden uit te oefenen (zie boven)."
    option :q11a03, :value => 3, :description => "Grote problemen op een of meer gebieden van zelfverzorging (eten, wassen, aankleden) of onvermogen om verscheidene complexe vaardigheden uit te oefenen."
    option :q11a04, :value => 4, :description => "Ernstige beperking op alle of bijna alle gebieden van zelfverzorging en / of complexe vaardigheden."
    option :q11a09, :value => 9, :description => "Geen of onvoldoende informatie voorhanden."
  end

  question :q12, :type => :radio do
    title "Problemen met gezinsleven en relaties"
    description "<strong>Inclusief:</strong> relatieproblemen tussen ouder en kind, en broers en zussen onderling.
                 <strong>Inclusief:</strong> relaties met pleegouders, maatschappelijk werkers / leerkrachten bij uithuisplaatsing. Zowel relaties thuis als met gescheiden ouders of broers en zussen die elders wonen, moeten worden opgenomen. Persoonlijkheidsproblemen, geestesziekten, huwelijksproblemen van de ouders moeten hier alleen worden gescoord wanneer zij effect hebben op het kind.
                 <strong>Inclusief:</strong> problemen met seksueel misbruik of mishandeling en emotionele mishandeling (zoals slechte communicatie, ruzies, verbale of fysieke vijandigheid, kritiek en denigrerende opmerkingen, verwaarlozing / afwijzing door de ouders en extreme strengheid).
                 <strong>Inclusief:</strong> jaloezie van broers / zussen, fysieke mishandeling of seksueel misbruik onder dwang door broer / zus.
                 <strong>Inclusief:</strong> problemen met verstrengeling en overprotectie.
                 <strong>Inclusief:</strong> problemen die gepaard gaan met overlijden van een gezinslid en leiden tot reorganisatie.
                 <strong>Exclusief:</strong> agressief gedrag van kind, te scoren op schaal 1."
                   
    option :q12a00, :value => 0, :description => "Geen problemen tijdens de beoordeelde periode"
    option :q12a01, :value => 1, :description => "Geringe of voorbijgaande problemen."
    option :q12a02, :value => 2, :description => "Licht maar duidelijk probleem, bijv. enkele perioden van verwaarlozing of vijandigheid of verstrengeling of overprotectie."
    option :q12a03, :value => 3, :description => "Matige problemen, bijv. verwaarlozing, mishandeling, vijandigheid. Problemen die gepaard gaan met uiteenvallen van een gezin, wegvallen van verzorger, of reorganisatie."
    option :q12a04, :value => 4, :description => "Ernstige problemen waarbij het kind zich het slachtoffer voelt / is van mishandeld of ernstig verwaarloosd worden door gezin of verzorger."
    option :q12a09, :value => 9, :description => "Geen of onvoldoende informatie voorhanden."
  end

  question :q13, :type => :radio do
    title "Afwezigheid van school"
    description "<strong>Inclusief:</strong> spijbelen, schoolweigering, afwezigheid of schorsing om welke reden dan ook.
                 <strong>Inclusief:</strong> schoolgaan naar type school ten tijde van het scoren, bijv. ziekenhuisschool, thuisonderwijs, enzovoort."
                   
    option :q13a00, :value => 0, :description => "Geen problemen van deze aard gedurende de beoordeelde periode"
    option :q13a01, :value => 1, :description => "Geringe problemen, bijv. te laat bij twee of meer lessen."
    option :q13a02, :value => 2, :description => "Duidelijke maar lichte problemen, bijv. verscheidene lessen gemist vanwege spijbelen of weigeren naar school te gaan."
    option :q13a03, :value => 3, :description => "Aanzienlijke problemen, verscheidene dagen afwezig tijdens de beoordeelde periode."
    option :q13a04, :value => 4, :description => "Ernstige problemen, de meeste of alle dagen afwezig. Enige vorm van schorsing, uitsluiting of van school sturen om welke reden dan ook tijdens de beoordeelde periode."
    option :q13a09, :value => 9, :description => "Geen of onvoldoende informatie voorhanden."
  end

  # Sectie B
  # Schaal 14 en 15 gaan over problemen voor kind, ouder of verzorger met betrekking tot gebrek aan informatie over, of toegang tot hulpverlening. Dit zijn geen directe maten voor de geestelijke gezondheid van het kind, maar veranderingen hierin kunnen baat voor het kind op de lange termijn opleveren.

  question :q14, :type => :radio do
    title "Problemen met kennis over of begrip van de aard van de problemen van het kind / de adolescent"
    description "<strong>Inclusief:</strong> gebrek aan bruikbare informatie of gebrekkig begrip ter beschikking van kind / adolescent, ouders of verzorgers.
                 <strong>Inclusief:</strong> gebrek aan uitleg over de diagnose of de oorzaak van het probleem of de prognose."
                   
    option :q14a00, :value => 0, :description => "Geen problemen tijdens de beoordeelde periode. Ouders / verzorgers zijn voldoende geïnformeerd over de problemen van het kind."
    option :q14a01, :value => 1, :description => "Slechts geringe problemen."
    option :q14a02, :value => 2, :description => "Licht maar duidelijk probleem."
    option :q14a03, :value => 3, :description => "Matig ernstige problemen. Ouders / verzorgers hebben zeer weinig of onjuiste kennis over het probleem, wat moeilijkheden veroorzaakt, zoals verwarring of zelfbeschuldiging."
    option :q14a04, :value => 4, :description => "Zeer ernstig probleem. Ouders hebben geen begrip van de aard van de problemen van hun kind."
    option :q14a09, :value => 9, :description => "Geen of onvoldoende informatie voorhanden."
  end

  question :q15, :type => :radio do
    title "Probleem met gebrek aan informatie over hulpverlening of omgaan met de problemen van het kind / de adolescent"
    description "<strong>Inclusief:</strong> gebrek aan nuttige informatie voor kind / adolescent, ouders verzorgers, of verwijzers.
                 <strong>Inclusief:</strong> gebrek aan informatie over de meest geschikte manier van hulpverlening aan het kind zoals zorgregelingen, of plaatsing op een school, of opvang, of subsidieaanvragen."
                   
    option :q15a00, :value => 0, :description => "Geen problemen tijdens de beoordeelde periode. De behoefte aan alle hulp die noodzakelijk is wordt onderkend."
    option :q15a01, :value => 1, :description => "Slechts geringe problemen."
    option :q15a02, :value => 2, :description => "Licht maar duidelijk probleem."
    option :q15a03, :value => 3, :description => "Matig ernstige problemen. Ouders / verzorgers hebben weinig informatie gekregen over geschikte hulpverlening, of hulpverleners weten niet wat ze met een kind aanmoeten."
    option :q15a04, :value => 4, :description => "Zeer ernstig probleem. Ouders hebben geen informatie over geschikte hulpverlening, of hulpverleners hebben geen idee wat ze met een kind aanmoeten."
    option :q15a09, :value => 9, :description => "Geen of onvoldoende informatie voorhanden."
  end

end

