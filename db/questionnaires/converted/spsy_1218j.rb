# SPsy.jongeren12-18

# Project ID 432
# Date (GMT) 06-12-2010 20:56:56
# All values between 1 and 8 auto-recoded with -1
# Manual recodes: 1,3,8:+1;7:+1 en dan 2;

key "spsy_1218j"
title "SPsy 12-18 Jongeren"
description ""

start_panel

question :v_1, :type => :radio do
  title "Waar ben je geboren?"
  description ""
  option :a1, :value => 1, :description => "Nederland"
  option :a2, :value => 2, :description => "Turkije"
  option :a3, :value => 3, :description => "Marokko"
  option :a4, :value => 4, :description => "Suriname"
  option :a5, :value => 5, :description => "Nederlandse Antillen"
  option :a6, :value => 6, :description => "Anders, namelijk: %s"
end

question :v_7, :type => :radio do
  title "Volg je momenteel een opleiding of ga je naar school?"
  description ""
  option :a1, :value => 1, :description => "Ja"
  option :a2, :value => 0, :description => "Nee"
end

question :v_3, :type => :radio do
  title "Welke opleiding of school volg je momenteel?"
  description ""
  option :a1, :value => 1, :description => "Geen"
  option :a2, :value => 2, :description => "Basisonderwijs"
  option :a3, :value => 3, :description => "(SBO) Speciale School voor Basisonderwijs"
  option :a4, :value => 4, :description => "(SO) Speciaal Onderwijs"
  option :a5, :value => 5, :description => "Praktijkschool"
  option :a6, :value => 6, :description => "(VSO) Voortgezet Speciaal Onderwijs"
  option :a7, :value => 7, :description => "(VMBO) Voorbereidend Middelbaar Beroeps Onderwijs"
  option :a8, :value => 8, :description => "(HAVO) Hoger Algemeen Voortgezet Onderwijs"
  option :a9, :value => 9, :description => "(VWO) Voorbereidend Wetenschappelijk Onderwijs"
  option :a10, :value => 10, :description => "(MBO, KMBO)Middelbaar Beroepsonderwijs"
  option :a11, :value => 11, :description => "(HBO) Hoger Beroepsonderwijs"
  option :a12, :value => 12, :description => "(WO) Wetenschappelijk Onderwijs"
  option :a13, :value => 13, :description => "Anders, namelijk: %s"
  option :a15, :value => 15, :description => "Typen voortgezet onderwijs:"
end

question :v_8, :type => :radio do
  title "Wat was je laatste school of opleiding?"
  description ""
  option :a1, :value => 1, :description => "Geen"
  option :a2, :value => 2, :description => "Basisonderwijs"
  option :a3, :value => 3, :description => "(SBO) Speciale School voor Basisonderwijs"
  option :a4, :value => 4, :description => "(SO) Speciaal Onderwijs"
  option :a5, :value => 5, :description => "Praktijkschool"
  option :a6, :value => 6, :description => "(VSO) Voortgezet Speciaal Onderwijs"
  option :a7, :value => 7, :description => "(VMBO) Voorbereidend Middelbaar Beroeps Onderwijs"
  option :a8, :value => 8, :description => "(HAVO) Hoger Algemeen Voortgezet Onderwijs"
  option :a9, :value => 9, :description => "(VWO) Voorbereidend Wetenschappelijk Onderwijs"
  option :a10, :value => 10, :description => "(MBO, KMBO)Middelbaar Beroepsonderwijs"
  option :a11, :value => 11, :description => "(HBO) Hoger Beroepsonderwijs"
  option :a12, :value => 12, :description => "(WO) Wetenschappelijk Onderwijs"
  option :a13, :value => 13, :description => "Anders, namelijk: %s"
  option :a15, :value => 15, :description => "Typen voortgezet onderwijs:"
end

question :v_12, :type => :open do
  title "Welke problemen, klachten of bijzonderheden zijn de aanleiding om hulp te zoeken. Wil je de belangrijkste problemen, hiernaast beschrijven; graag zo kort en duidelijk mogelijk."
  description ""
end

question :v_12, :type => :open do
  title "Probleem 1 v_13"
  description ""
end

question :v_13, :type => :open do
  title "Probleem 2 v_14"
  description ""
end

question :v_14, :type => :open do
  title "Probleem 3"
  description ""
end

question :v_15, :type => :radio do
  title "1. Ik probeer aardig te zijn tegen anderen. Ik houd rekening met hun gevoelens."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_16, :type => :radio do
  title "2. Ik ben rusteloos, ik kan niet lang stilzitten."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_17, :type => :radio do
  title "3. Ik heb vaak hoofdpijn, buikpijn, of ik ben misselijk"
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_18, :type => :radio do
  title "4. Ik deel makkelijk met anderen (snoep, speelgoed, potloden, enz)."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_19, :type => :radio do
  title "5. Ik word erg boos en ben vaak driftig."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_20, :type => :radio do
  title "6. Ik ben nogal op mijzelf. Ik speel meestal alleen of bemoei mij niet met anderen."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_21, :type => :radio do
  title "7. Ik doe meestal wat me wordt opgedragen."
  description ""
  option :a1, :value => 0, :description => "Zeker waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Niet waar"
end

question :v_22, :type => :radio do
  title "8. Ik pieker veel."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_23, :type => :radio do
  title "9. Ik help iemand die zich heeft bezeerd, van streek is of zich ziek voelt."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_24, :type => :radio do
  title "10. Ik zit constant te wiebelen of te friemelen."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_25, :type => :radio do
  title "11. Ik heb minstens 'e'en goede vriend of vriendin."
  description ""
  option :a1, :value => 0, :description => "Zeker waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Niet waar"
end

question :v_26, :type => :radio do
  title "12. Ik vecht vaak. Het lukt mij andere mensen te laten doen wat ik wil."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_27, :type => :radio do
  title "13. Ik ben vaak ongelukkig, in de put of in tranen."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_28, :type => :radio do
  title "14. Andere jongeren van mijn leeftijd vinden mij over het algemeen aardig."
  description ""
  option :a1, :value => 0, :description => "Zeker waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Niet waar"
end

question :v_29, :type => :radio do
  title "15. Ik ben snel afgeleid, ik vind het moeilijk om me te concentreren."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_30, :type => :radio do
  title "16. Ik ben zenuwachtig in nieuwe situaties. Ik verlies makkelijk mijn zelfvertrouwen."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_31, :type => :radio do
  title "17. Ik ben aardig tegen jongere kinderen."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_32, :type => :radio do
  title "18. Ik word er vaak van beschuldigd dat ik lieg of bedrieg."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_33, :type => :radio do
  title "19. Andere kinderen of jongeren pesten of treiteren mij."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_34, :type => :radio do
  title "20. Ik bied vaak anderen aan hen te helpen (ouders, leerkrachten, andere kinderen)."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_35, :type => :radio do
  title "21. Ik denk na voor ik iets doe."
  description ""
  option :a1, :value => 0, :description => "Zeker waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Niet waar"
end

question :v_36, :type => :radio do
  title "22. Ik neem dingen weg die niet van mij zijn thuis, op school of op andere plaatsen."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_37, :type => :radio do
  title "23. Ik kan beter met volwassenen opschieten dan met leeftijdgenoten."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_38, :type => :radio do
  title "24. Ik ben voor heel veel dingen bang, ik ben snel angstig."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_39, :type => :radio do
  title "25. Ik maak af waar ik mee bezig ben. Ik kan mijn aandacht er goed bij houden."
  description ""
  option :a1, :value => 0, :description => "Zeker waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Niet waar"
end

question :v_40, :type => :radio do
  title "26. Ik heb het gevoel gehad alsof andere mensen mijn gedachten kunnen lezen."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_41, :type => :radio do
  title "27. Ik kan me vaak niet beheersen en eet dan enorm veel."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_42, :type => :radio do
  title "28. Ik heb expres geprobeerd mezelf iets aan te doen (bijvoorbeeld snijden, slaan)."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_43, :type => :radio do
  title "29. Ik doe erg mijn best om af te vallen (bijv. strenge di'eten volgen of bijna niet eten)."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_44, :type => :radio do
  title "30. Ik heb het gevoel alsof ik boodschappen krijg via de radio of televisie die alleen voor mij bestemd zijn."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_45, :type => :radio do
  title "31. Ik vind mijzelf dik, ook al zeggen anderen dat dit niet zo is."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_46, :type => :radio do
  title "32. Ik heb in de afgelopen week erover nagedacht een einde aan mijn leven te maken."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_47, :type => :radio do
  title "33. Ik heb het gevoel gehad alsof mensen me achtervolgen en bespioneren."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_48, :type => :radio do
  title "34. Ik geef soms expres over na het eten."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_49, :type => :radio do
  title "35. Ik heb het gevoel gehad alsof ik stemmen hoor die andere mensen niet kunnen horen."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_50, :type => :radio do
  title "36. Ik vind dat eten mijn leven beheerst."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_51, :type => :radio do
  title "37. Gebruik je wel eens alcohol?"
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_52, :type => :radio do
  title "37. Gebruik je wel eens alcohol?"
  description ""
  option :a1, :value => 0, :description => "niet in de afgelopen zes maanden"
  option :a2, :value => 1, :description => "eens per maand of minder"
  option :a3, :value => 2, :description => "2-4 keer per maand"
  option :a4, :value => 3, :description => "2-3 keer per week"
  option :a5, :value => 4, :description => "4 keer per week of vaker"
end

question :v_54, :type => :radio do
  title "38. Ik denk dat het goed is als ik wat minder alcohol zou gebruiken."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_55, :type => :radio do
  title "39. Ik heb het afgelopen jaar problemen gehad door mijn alcoholgebruik (op school, thuis of werk)."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_56, :type => :radio do
  title "40. Iemand (een familielid of vriend) heeft zijn of haar bezorgdheid geuit over mijn alcoholgebruik of me gezegd te stoppen met het gebruik van alcohol."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_57, :type => :radio do
  title "41. Gebruik je wel eens drugs? (drugs zijn hasj, weed, marihuana, XTC, hero'ine, coca'ine, paddo's, slaappillen enz.; pillen tellen niet als drugs als je ze verkregen hebt van de dokter)."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_58, :type => :radio do
  title "41. Gebruik je wel eens drugs?"
  description ""
  option :a1, :value => 0, :description => "niet in de afgelopen zes maanden"
  option :a2, :value => 1, :description => "eens per maand of minder"
  option :a3, :value => 2, :description => "2-4 keer per maand"
  option :a4, :value => 3, :description => "2-3 keer per week"
  option :a5, :value => 4, :description => "4 keer per week of vaker"
end

question :v_59, :type => :radio do
  title "42. Ik denk dat het goed is als ik wat minder drugs zou gebruiken."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_60, :type => :radio do
  title "43. Ik heb problemen gehad door mijn drugsgebruik (op school, thuis of werk)."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_61, :type => :radio do
  title "44. Iemand (een familielid of vriend) heeft zijn of haar bezorgdheid geuit over mijn drugsgebruik of me gezegd te stoppen met het gebruik van drugs."
  description ""
  option :a1, :value => 0, :description => "Niet waar"
  option :a2, :value => 1, :description => "Beetje waar"
  option :a3, :value => 2, :description => "Zeker waar"
end

question :v_62, :type => :open do
  title "45. Hoeveel weeg je?"
  description ""
end

question :v_63, :type => :open do
  title "46. Hoe lang ben je?"
  description ""
end

question :v_63, :type => :open do
  title "v_64"
  description ""
end

question :v_88, :type => :radio do
  title "47. Denk je over het geheel genomen dat je moeilijkheden hebt op 'e'en of meer van de volgende gebieden: emoties, concentratie, gedrag of vermogen om met andere mensen op te schieten?"
  description ""
  option :a1, :value => 0, :description => "Nee"
  option :a2, :value => 1, :description => "Ja, kleine moeilijkheden"
  option :a3, :value => 2, :description => "Ja, duidelijke moeilijkheden"
  option :a4, :value => 3, :description => "Ja, ernstige moeilijkheden"
end

question :v_89, :type => :radio do
  title "48. Hoe lang bestaan deze moeilijkheden?"
  description ""
  option :a1, :value => 0, :description => "Korter dan een maand"
  option :a2, :value => 1, :description => "1 - 5 maanden"
  option :a3, :value => 2, :description => "6 - 12 maanden"
  option :a4, :value => 3, :description => "Meer dan een jaar"
end

question :v_90, :type => :radio do
  title "49. Maken de moeilijkheden je overstuur of van slag?"
  description ""
  option :a1, :value => 0, :description => "Helemaal niet"
  option :a2, :value => 1, :description => "Een beetje maar"
  option :a3, :value => 2, :description => "Tamelijk"
  option :a4, :value => 3, :description => "Heel erg"
end

question :v_96, :type => :radio do
  title "50. Belemmeren de moeilijkheden jouw dagelijks leven op de volgende gebieden?"
  description ""
end

question :v_96, :type => :radio do
  title "Thuis"
  description ""
  option :a1, :value => 0, :description => "Helemaal niet"
  option :a2, :value => 1, :description => "Een beetje maar"
  option :a3, :value => 2, :description => "Tamelijk"
  option :a4, :value => 3, :description => "Heel erg"
end

question :v_97, :type => :radio do
  title "Vriendschappen"
  description ""
  option :a1, :value => 0, :description => "Helemaal niet"
  option :a2, :value => 1, :description => "Een beetje maar"
  option :a3, :value => 2, :description => "Tamelijk"
  option :a4, :value => 3, :description => "Heel erg"
end

question :v_98, :type => :radio do
  title "Leren in de klas"
  description ""
  option :a1, :value => 0, :description => "Helemaal niet"
  option :a2, :value => 1, :description => "Een beetje maar"
  option :a3, :value => 2, :description => "Tamelijk"
  option :a4, :value => 3, :description => "Heel erg"
end

question :v_99, :type => :radio do
  title "Activiteiten in de vrije tijd"
  description ""
  option :a1, :value => 0, :description => "Helemaal niet"
  option :a2, :value => 1, :description => "Een beetje maar"
  option :a3, :value => 2, :description => "Tamelijk"
  option :a4, :value => 3, :description => "Heel erg"
end

question :v_100, :type => :radio do
  title "51. Maken de moeilijkheden het lastiger voor de mensen in jouw omgeving (gezin, vrienden, leerkrachten, enz)?"
  description ""
  option :a1, :value => 0, :description => "Helemaal niet"
  option :a2, :value => 1, :description => "Een beetje maar"
  option :a3, :value => 2, :description => "Tamelijk"
  option :a4, :value => 3, :description => "Heel erg"
end

question :v_101, :type => :open do
  title "52. Overige opmerkingen:"
  description ""
end

end_panel

