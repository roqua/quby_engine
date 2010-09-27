# SPsy.ouders4-11

# Project ID 84342
# Date (GMT) 15-01-2010 08:58:49

title "SPsy 4-11 Ouders"

question :q1866292, :type => :radio do
  title "Deze vragenlijst wordt ingevuld door:"
  description ""
  option :a1, :value => 1, :description => "Vader"
  option :a2, :value => 2, :description => "Moeder"
  option :a3, :value => 3, :description => "Anders" do
    question :q1866292_other, :type => :string, :title => "Namelijk"
  end
end

panel do

  question :q860379, :type => :radio do
    title "1. Waar is uw kind geboren?"
    description ""
    option :a1, :value => 1, :description => "Nederland"
    option :a2, :value => 2, :description => "Turkije"
    option :a3, :value => 3, :description => "Marokko"
    option :a4, :value => 4, :description => "Suriname"
    option :a5, :value => 5, :description => "Nederlandse Antillen"
    option :a6, :value => 6, :description => "Anders" do
      question :q1866292_other, :type => :string, :title => "Namelijk"
    end
  end
  
  question :q860388, :type => :radio do
    title "2. Volgt uw kind momenteel een opleiding of school?"
    description ""
    option :a1, :value => 1, :description => "Ja"
    option :a2, :value => 2, :description => "Nee"
  end
  
  question :q860383, :type => :radio do
    title "2a. Welke opleiding of school volgt uw kind momenteel?"
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
    option :a13, :value => 13, :description => "Anders" do
      question :q860383_other, :type => :string, :title => "Namelijk"
    end
    option :a14, :value => 14, :description => "Typen basisonderwijs:"
    option :a15, :value => 15, :description => "Typen voortgezet onderwijs:"
  end
  
  question :q860390, :type => :radio do
    title "2b. Wat was zijn/haar laatste school of opleiding?"
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
    option :a13, :value => 13, :description => "Anders" do
      question :q860390_other, :type => :string, :title => "Namelijk"
    end
    option :a14, :value => 14, :description => "Typen basisonderwijs:"
    option :a15, :value => 15, :description => "Typen voortgezet onderwijs:"
  end
end

panel do
  text "3. Welke problemen, klachten of bijzonderheden zijn de aanleiding om hulp te zoeken. Wilt u de belangrijkste problemen, hieronder beschrijven; graag zo kort en duidelijk mogelijk."
  
  question :q12, :type => :string do
    title "Probleem 1"
    description ""
  end
  
  question :q13, :type => :string do
    title "Probleem 2"
    description ""
  end
  
  question :q14, :type => :string do
    title "Probleem 3"
    description ""
  end
end

question :q860405, :type => :radio do
  title "4. Probeert aardig te zijn tegen anderen. Houdt rekening met hun gevoelens."
  description ""
  option :a1, :value => 1, :description => "Niet waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Zeker waar"
end

question :q860411, :type => :radio do
  title "5. Is rusteloos, kan niet lang stilzitten."
  description ""
  option :a1, :value => 1, :description => "Niet waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Zeker waar"
end

question :q860414, :type => :radio do
  title "6. Klaagt vaak over hoofdpijn, buikpijn, of misselijkheid."
  description ""
  option :a1, :value => 1, :description => "Niet waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Zeker waar"
end

question :q860418, :type => :radio do
  title "7. Deelt makkelijk met andere kinderen (snoep, speelgoed, potloden, enz)."
  description ""
  option :a1, :value => 1, :description => "Niet waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Zeker waar"
end

question :q860420, :type => :radio do
  title "8. Wordt erg boos en is vaak driftig."
  description ""
  option :a1, :value => 1, :description => "Niet waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Zeker waar"
end

question :q860422, :type => :radio do
  title "9. Is nogal op zichzelf. Speelt meestal alleen of bemoeit zich niet met anderen."
  description ""
  option :a1, :value => 1, :description => "Niet waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Zeker waar"
end

question :q860424, :type => :radio do
  title "10. Doet meestal wat hem/haar wordt opgedragen."
  description ""
  option :a1, :value => 1, :description => "Zeker waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Niet waar"
end

question :q860427, :type => :radio do
  title "11. Piekert veel."
  description ""
  option :a1, :value => 1, :description => "Niet waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Zeker waar"
end

question :q860431, :type => :radio do
  title "12. Helpt iemand die zich heeft bezeerd, van streek is of zich ziek voelt."
  description ""
  option :a1, :value => 1, :description => "Niet waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Zeker waar"
end

question :q860433, :type => :radio do
  title "13. Zit constant te wiebelen of te friemelen."
  description ""
  option :a1, :value => 1, :description => "Niet waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Zeker waar"
end

question :q860435, :type => :radio do
  title "14. Heeft minstens één goede vriend of vriendin."
  description ""
  option :a1, :value => 1, :description => "Zeker waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Niet waar"
end

question :q860437, :type => :radio do
  title "15. Vecht vaak. Het lukt uw kind andere mensen te laten doen wat hij/zij wil."
  description ""
  option :a1, :value => 1, :description => "Niet waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Zeker waar"
end

question :q860440, :type => :radio do
  title "16. Is vaak ongelukkig, in de put of in tranen."
  description ""
  option :a1, :value => 1, :description => "Niet waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Zeker waar"
end

question :q860442, :type => :radio do
  title "17. Wordt over het algemeen aardig gevonden door andere kinderen."
  description ""
  option :a1, :value => 1, :description => "Zeker waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Niet waar"
end

question :q860444, :type => :radio do
  title "18. Is snel afgeleid, vindt het moeilijk zich te concentreren."
  description ""
  option :a1, :value => 1, :description => "Niet waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Zeker waar"
end

question :q860447, :type => :radio do
  title "19. Is zenuwachtig in nieuwe situaties. Verliest makkelijk zelfvertrouwen."
  description ""
  option :a1, :value => 1, :description => "Niet waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Zeker waar"
end

question :q860449, :type => :radio do
  title "20. Is aardig tegen jonge kinderen."
  description ""
  option :a1, :value => 1, :description => "Niet waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Zeker waar"
end

question :q860451, :type => :radio do
  title "21. Liegt of bedriegt vaak."
  description ""
  option :a1, :value => 1, :description => "Niet waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Zeker waar"
end

question :q860454, :type => :radio do
  title "22. Wordt getreiterd of gepest door andere kinderen."
  description ""
  option :a1, :value => 1, :description => "Niet waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Zeker waar"
end

question :q860456, :type => :radio do
  title "23. Biedt vaak vrijwillig hulp aan anderen (ouders, leerkrachten, andere kinderen)."
  description ""
  option :a1, :value => 1, :description => "Niet waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Zeker waar"
end

question :q860458, :type => :radio do
  title "24. Denkt na voor iets te doen."
  description ""
  option :a1, :value => 1, :description => "Zeker waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Niet waar"
end

question :q860461, :type => :radio do
  title "25. Pikt dingen thuis, op school of op andere plaatsen."
  description ""
  option :a1, :value => 1, :description => "Niet waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Zeker waar"
end

question :q860463, :type => :radio do
  title "26. Kan beter opschieten met volwassenen dan met leeftijdgenoten."
  description ""
  option :a1, :value => 1, :description => "Niet waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Zeker waar"
end

question :q860465, :type => :radio do
  title "27. Is voor heel veel dingen bang, is snel angstig."
  description ""
  option :a1, :value => 1, :description => "Niet waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Zeker waar"
end

question :q860468, :type => :radio do
  title "28. Maakt af waar hij/zij mee bezig is. Kan de aandacht er goed bijhouden."
  description ""
  option :a1, :value => 1, :description => "Zeker waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Niet waar"
end

question :q860471, :type => :radio do
  title "29. Heeft het gevoel gehad alsof andere mensen zijn/haar gedachten kunnen lezen."
  description ""
  option :a1, :value => 1, :description => "Niet waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Zeker waar"
end

question :q860475, :type => :radio do
  title "30. Kan zich vaak niet beheersen en eet dan enorm veel."
  description ""
  option :a1, :value => 1, :description => "Niet waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Zeker waar"
end

question :q860479, :type => :radio do
  title "31. Heeft expres geprobeerd zichzelf iets aan te doen (bijvoorbeeld snijden, slaan)."
  description ""
  option :a1, :value => 1, :description => "Niet waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Zeker waar"
end

question :q860481, :type => :radio do
  title "32. Doet erg zijn/haar best om af te vallen."
  description ""
  option :a1, :value => 1, :description => "Niet waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Zeker waar"
end

question :q860483, :type => :radio do
  title "33. Heeft het gevoel gehad boodschappen te krijgen via de radio of televisie die alleen voor hem/haar bestemd zijn."
  description ""
  option :a1, :value => 1, :description => "Niet waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Zeker waar"
end

question :q860485, :type => :radio do
  title "34. Vindt zichzelf dik, ook al zeggen anderen dat dit niet zo is."
  description ""
  option :a1, :value => 1, :description => "Niet waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Zeker waar"
end

question :q860488, :type => :radio do
  title "35. Heeft in de afgelopen week erover nagedacht een einde aan het leven te maken."
  description ""
  option :a1, :value => 1, :description => "Niet waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Zeker waar"
end

question :q860490, :type => :radio do
  title "36. Heeft het gevoel gehad achtervolgd en bespioneerd te worden."
  description ""
  option :a1, :value => 1, :description => "Niet waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Zeker waar"
end

question :q860493, :type => :radio do
  title "37. Geeft soms expres over na het eten."
  description ""
  option :a1, :value => 1, :description => "Niet waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Zeker waar"
end

question :q860498, :type => :radio do
  title "38. Heeft het gevoel gehad stemmen te horen die andere mensen niet kunnen horen."
  description ""
  option :a1, :value => 1, :description => "Niet waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Zeker waar"
end

question :q860508, :type => :radio do
  title "39. Vindt dat eten zijn/haar leven beheerst."
  description ""
  option :a1, :value => 1, :description => "Niet waar"
  option :a2, :value => 2, :description => "Beetje waar"
  option :a3, :value => 3, :description => "Zeker waar"
end

question :q860604, :type => :string do
  title "40. Gewicht kind?"
  description ""
end

question :q860605, :type => :string do
  title "41. Lengte kind?"
  description ""
end

question :q860609, :type => :radio do
  title "42. Denkt u over het geheel genomen dat uw kind moeilijkheden heeft op één van de volgende gebieden: emoties, concentratie, gedrag of vermogen om met andere mensen op te schieten?"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Ja, kleine moeilijkheden"
  option :a3, :value => 3, :description => "Ja, duidelijke moeilijkheden"
  option :a4, :value => 4, :description => "Ja, ernstige moeilijkheden"
end

question :q860613, :type => :radio do
  title "43. Hoe lang bestaan deze moeilijkheden?"
  description ""
  option :a1, :value => 1, :description => "Korter dan een maand"
  option :a2, :value => 2, :description => "1 tot 5 maanden"
  option :a3, :value => 3, :description => "6 tot 12 maanden"
  option :a4, :value => 4, :description => "Meer dan een jaar"
end

question :q860614, :type => :radio do
  title "44. Maken de moeilijkheden uw kind overstuur of van slag?"
  description ""
  option :a1, :value => 1, :description => "Helemaal niet"
  option :a2, :value => 2, :description => "Een beetje maar"
  option :a3, :value => 3, :description => "Tamelijk"
  option :a4, :value => 4, :description => "Heel erg"
end

panel do
  text "45. Belemmeren de moeilijkheden het dagelijkse leven van uw kind op de volgende gebieden?"
  
  question :q96, :type => :radio do
    title "a. Thuis"
    description ""
    option :a1, :value => 1, :description => "Helemaal niet"
    option :a2, :value => 2, :description => "Een beetje maar"
    option :a3, :value => 3, :description => "Tamelijk"
    option :a4, :value => 4, :description => "Heel erg"
  end
  
  question :q97, :type => :radio do
    title "b. Vriendschappen"
    description ""
    option :a1, :value => 1, :description => "Helemaal niet"
    option :a2, :value => 2, :description => "Een beetje maar"
    option :a3, :value => 3, :description => "Tamelijk"
    option :a4, :value => 4, :description => "Heel erg"
  end
  
  question :q98, :type => :radio do
    title "c. Leren in de klas"
    description ""
    option :a1, :value => 1, :description => "Helemaal niet"
    option :a2, :value => 2, :description => "Een beetje maar"
    option :a3, :value => 3, :description => "Tamelijk"
    option :a4, :value => 4, :description => "Heel erg"
  end
  
  question :q99, :type => :radio do
    title "d. Activiteiten in de vrije tijd"
    description ""
    option :a1, :value => 1, :description => "Helemaal niet"
    option :a2, :value => 2, :description => "Een beetje maar"
    option :a3, :value => 3, :description => "Tamelijk"
    option :a4, :value => 4, :description => "Heel erg"
  end
end

question :q860619, :type => :radio do
  title "46. Belasten de moeilijkheden u of het gezin als geheel?"
  description ""
  option :a1, :value => 1, :description => "Helemaal niet"
  option :a2, :value => 2, :description => "Een beetje maar"
  option :a3, :value => 3, :description => "Tamelijk"
  option :a4, :value => 4, :description => "Heel erg"
end

question :q860621, :type => :string do
  title "47. Overige opmerkingen:"
  description ""
end

