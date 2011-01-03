# NEO-FFI - Neuroticism-Extroversion-Openness Five Factor Inventory

# Project ID 480
# Date (GMT) 06-12-2010 20:53:18
# No values auto-recoded
# No manual recodes needed

key "neo-ffi"
title "Neuroticism-Extroversion-Openness Five Factor Inventory (NEO-FFI)"
description ""

panel do
 title "NEO-FFI Persoonlijkheidsvragenlijst"
 text "Deze vragenlijst bevat 60 uitspraken.

Lees elke uitspraak zorgvuldig en geef vlot aan of u het er mee eens of oneens bent door het passende antwoord aan te klikken.

Klik op 'Volgende' om verder te gaan.

NEO-FFI, H.A. Hoekstra, J.Ormel en F. de Fruyt, (c) 2007 Hogrefe Uitgevers BV, (c) 1989 Psychological Assessment Recources, Odessa, Florida."
end


panel do
question :v_1, :type => :radio do
  title "1. Ik ben geen tobber."
  description ""
  option :a1, :value => 1, :description => "Helemaal eens"
  option :a2, :value => 2, :description => "Eens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Oneens"
  option :a5, :value => 5, :description => "Helemaal oneens"
end

question :v_2, :type => :radio do
  title "2. Ik houd er van veel mensen om me heen te hebben."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_3, :type => :radio do
  title "3. Ik houd er niet van mijn tijd te verdoen met dagdromen."
  description ""
  option :a1, :value => 1, :description => "Helemaal eens"
  option :a2, :value => 2, :description => "Eens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Oneens"
  option :a5, :value => 5, :description => "Helemaal oneens"
end

question :v_4, :type => :radio do
  title "4. Ik probeer hoffelijk te zijn tegen iedereen die ik ontmoet."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_6, :type => :radio do
  title "5. Ik houd mijn spullen netjes en schoon."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end
end

panel do
question :v_7, :type => :radio do
  title "6. Ik voel me vaak de mindere van anderen."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_8, :type => :radio do
  title "7. Ik lach gemakkelijk."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_9, :type => :radio do
  title "8. Als ik eenmaal de goede manier om iets te doen gevonden heb, dan blijf ik daar bij."
  description ""
  option :a1, :value => 1, :description => "Helemaal eens"
  option :a2, :value => 2, :description => "Eens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Oneens"
  option :a5, :value => 5, :description => "Helemaal oneens"
end

question :v_10, :type => :radio do
  title "9. Ik verzeil vaak in meningsverschillen met mijn familie en collega's."
  description ""
  option :a1, :value => 1, :description => "Helemaal eens"
  option :a2, :value => 2, :description => "Eens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Oneens"
  option :a5, :value => 5, :description => "Helemaal oneens"
end

question :v_11, :type => :radio do
  title "10. Ik kan mijzelf vrij goed oppeppen om dingen op tijd af te krijgen."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end
end

panel do
question :v_12, :type => :radio do
  title "11. Wanneer ik onder grote spanning sta, heb ik soms het gevoel dat ik er aan onderdoor ga."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_13, :type => :radio do
  title "12. Ik zie mijzelf niet echt als een vrolijk en opgewekt persoon."
  description ""
  option :a1, :value => 1, :description => "Helemaal eens"
  option :a2, :value => 2, :description => "Eens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Oneens"
  option :a5, :value => 5, :description => "Helemaal oneens"
end

question :v_14, :type => :radio do
  title "13. Ik ben ge'intrigeerd door de patronen die ik vind in de kunst en de natuur."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_15, :type => :radio do
  title "14. Sommige mensen vinden mij zelfzuchtig en ego'istisch."
  description ""
  option :a1, :value => 1, :description => "Helemaal eens"
  option :a2, :value => 2, :description => "Eens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Oneens"
  option :a5, :value => 5, :description => "Helemaal oneens"
end

question :v_16, :type => :radio do
  title "15. Ik ben niet erg systematisch."
  description ""
  option :a1, :value => 1, :description => "Helemaal eens"
  option :a2, :value => 2, :description => "Eens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Oneens"
  option :a5, :value => 5, :description => "Helemaal oneens"
end
end

panel do
question :v_17, :type => :radio do
  title "16. Ik voel me zelden eenzaam of triest."
  description ""
  option :a1, :value => 1, :description => "Helemaal eens"
  option :a2, :value => 2, :description => "Eens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Oneens"
  option :a5, :value => 5, :description => "Helemaal oneens"
end

question :v_18, :type => :radio do
  title "17. Ik vind het echt leuk om met mensen te praten."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_19, :type => :radio do
  title "18. Ik vind dat leerlingen alleen maar in verwarring worden gebracht door ze te laten luisteren naar sprekers met afwijkende idee'en."
  description ""
  option :a1, :value => 1, :description => "Helemaal eens"
  option :a2, :value => 2, :description => "Eens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Oneens"
  option :a5, :value => 5, :description => "Helemaal oneens"
end

question :v_20, :type => :radio do
  title "19. Ik werk liever met anderen samen dan met ze te wedijveren."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_21, :type => :radio do
  title "20. Ik probeer alle aan mij opgedragen taken gewetensvol uit te voeren."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end
end

panel do
question :v_22, :type => :radio do
  title "21. Ik voel me vaak gespannen en zenuwachtig."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_23, :type => :radio do
  title "22. Ik ben graag daar waar wat te beleven valt."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_24, :type => :radio do
  title "23. Po'ezie doet mij weinig tot niets."
  description ""
  option :a1, :value => 1, :description => "Helemaal eens"
  option :a2, :value => 2, :description => "Eens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Oneens"
  option :a5, :value => 5, :description => "Helemaal oneens"
end

question :v_25, :type => :radio do
  title "24. Ik ben vaak cynisch en sceptisch over de bedoelingen van anderen."
  description ""
  option :a1, :value => 1, :description => "Helemaal eens"
  option :a2, :value => 2, :description => "Eens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Oneens"
  option :a5, :value => 5, :description => "Helemaal oneens"
end

question :v_26, :type => :radio do
  title "25. Ik heb duidelijke doelen voor ogen en werk daar op een systematische manier naar toe."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end
end

panel do
question :v_27, :type => :radio do
  title "26. Soms voel ik me volkomen waardeloos."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_28, :type => :radio do
  title "27. Ik geef er meestal de voorkeur aan om dingen alleen te doen."
  description ""
  option :a1, :value => 1, :description => "Helemaal eens"
  option :a2, :value => 2, :description => "Eens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Oneens"
  option :a5, :value => 5, :description => "Helemaal oneens"
end

question :v_29, :type => :radio do
  title "28. Ik probeer vaak nieuwe en buitenlandse gerechten."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_30, :type => :radio do
  title "29. Ik denk dat de meeste mensen je zullen gebruiken als je ze de kans geeft."
  description ""
  option :a1, :value => 1, :description => "Helemaal eens"
  option :a2, :value => 2, :description => "Eens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Oneens"
  option :a5, :value => 5, :description => "Helemaal oneens"
end

question :v_31, :type => :radio do
  title "30. Ik verknoei veel tijd voordat ik echt aan het werk ga."
  description ""
  option :a1, :value => 1, :description => "Helemaal eens"
  option :a2, :value => 2, :description => "Eens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Oneens"
  option :a5, :value => 5, :description => "Helemaal oneens"
end
end

panel do
question :v_32, :type => :radio do
  title "31. Ik voel me zelden angstig of zorgelijk."
  description ""
  option :a1, :value => 1, :description => "Helemaal eens"
  option :a2, :value => 2, :description => "Eens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Oneens"
  option :a5, :value => 5, :description => "Helemaal oneens"
end

question :v_33, :type => :radio do
  title "32. Ik voel me vaak alsof ik barst van energie."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_34, :type => :radio do
  title "33. Ik merk zelden de stemmingen of gevoelens op, die verschillende omgevingen oproepen."
  description ""
  option :a1, :value => 1, :description => "Helemaal eens"
  option :a2, :value => 2, :description => "Eens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Oneens"
  option :a5, :value => 5, :description => "Helemaal oneens"
end

question :v_35, :type => :radio do
  title "34. De meeste mensen die ik ken mogen mij graag."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_36, :type => :radio do
  title "35. Ik werk hard om mijn doelen te bereiken."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end
end

panel do
question :v_37, :type => :radio do
  title "36. Ik word vaak kwaad om de manier waarop mensen me behandelen."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_38, :type => :radio do
  title "37. Ik ben een vrolijk en levendig iemand."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_39, :type => :radio do
  title "38. Ik vind dat we beslissingen in morele zaken van onze religieuze leiders mogen verwachten."
  description ""
  option :a1, :value => 1, :description => "Helemaal eens"
  option :a2, :value => 2, :description => "Eens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Oneens"
  option :a5, :value => 5, :description => "Helemaal oneens"
end

question :v_40, :type => :radio do
  title "39. Sommige mensen vinden mij koel en berekenend."
  description ""
  option :a1, :value => 1, :description => "Helemaal eens"
  option :a2, :value => 2, :description => "Eens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Oneens"
  option :a5, :value => 5, :description => "Helemaal oneens"
end

question :v_41, :type => :radio do
  title "40. Als ik iets beloof, kan men er op rekenen dat ik die belofte ook nakom."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end
end

panel do
question :v_42, :type => :radio do
  title "41. Wanneer dingen mis gaan raak ik maar al te vaak ontmoedigd en heb ik zin om het op te geven."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_43, :type => :radio do
  title "42. Ik ben geen vrolijke optimist."
  description ""
  option :a1, :value => 1, :description => "Helemaal eens"
  option :a2, :value => 2, :description => "Eens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Oneens"
  option :a5, :value => 5, :description => "Helemaal oneens"
end

question :v_44, :type => :radio do
  title "43. Wanneer ik een gedicht lees of naar een kunstwerk kijk, voel ik soms een koude rilling of een golf van opwinding."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_45, :type => :radio do
  title "44. Ik ben zakelijk en onsentimenteel in mijn opvattingen."
  description ""
  option :a1, :value => 1, :description => "Helemaal eens"
  option :a2, :value => 2, :description => "Eens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Oneens"
  option :a5, :value => 5, :description => "Helemaal oneens"
end

question :v_46, :type => :radio do
  title "45. Soms ben ik niet zo betrouwbaar als ik zou moeten zijn."
  description ""
  option :a1, :value => 1, :description => "Helemaal eens"
  option :a2, :value => 2, :description => "Eens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Oneens"
  option :a5, :value => 5, :description => "Helemaal oneens"
end
end

panel do
question :v_47, :type => :radio do
  title "46. Ik ben zelden verdrietig of depressief."
  description ""
  option :a1, :value => 1, :description => "Helemaal eens"
  option :a2, :value => 2, :description => "Eens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Oneens"
  option :a5, :value => 5, :description => "Helemaal oneens"
end

question :v_48, :type => :radio do
  title "47. Ik heb een jachtig leven."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_49, :type => :radio do
  title "48. Ik ben niet erg ge'interesseerd in het speculeren over het wezen van het universum of van de mens."
  description ""
  option :a1, :value => 1, :description => "Helemaal eens"
  option :a2, :value => 2, :description => "Eens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Oneens"
  option :a5, :value => 5, :description => "Helemaal oneens"
end

question :v_50, :type => :radio do
  title "49. Over het algemeen probeer ik attent en zorgzaam te zijn."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_51, :type => :radio do
  title "50. Ik ben een productief mens die een klus altijd voor elkaar krijgt."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end
end

panel do
question :v_52, :type => :radio do
  title "51. Ik voel me vaak hulpeloos en wil dan graag dat iemand anders mijn problemen oplost."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_53, :type => :radio do
  title "52. Ik ben een heel actief persoon."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_54, :type => :radio do
  title "53. Ik heb een breed scala aan intellectuele interessen."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_55, :type => :radio do
  title "54. Als ik mensen niet mag, laat ik dat ook merken."
  description ""
  option :a1, :value => 1, :description => "Helemaal eens"
  option :a2, :value => 2, :description => "Eens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Oneens"
  option :a5, :value => 5, :description => "Helemaal oneens"
end

question :v_56, :type => :radio do
  title "55. Het lijkt mij maar niet te lukken om de dingen goed op orde te hebben."
  description ""
  option :a1, :value => 1, :description => "Helemaal eens"
  option :a2, :value => 2, :description => "Eens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Oneens"
  option :a5, :value => 5, :description => "Helemaal oneens"
end
end

panel do
question :v_57, :type => :radio do
  title "56. Soms schaam ik me zo dat ik wel door de grond wil zakken."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_58, :type => :radio do
  title "57. Ik ga liever mijn eigen gang dan dat ik leiding geef aan anderen."
  description ""
  option :a1, :value => 1, :description => "Helemaal eens"
  option :a2, :value => 2, :description => "Eens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Oneens"
  option :a5, :value => 5, :description => "Helemaal oneens"
end

question :v_59, :type => :radio do
  title "58. Ik heb vaak plezier in het spelen met theorie'en of abstracte idee'en."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_60, :type => :radio do
  title "59. Als het nodig is ben ik bereid om mensen te manipuleren om te krijgen wat ik wil."
  description ""
  option :a1, :value => 1, :description => "Helemaal eens"
  option :a2, :value => 2, :description => "Eens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Oneens"
  option :a5, :value => 5, :description => "Helemaal oneens"
end

question :v_61, :type => :radio do
  title "60. Ik streef er naar uit te blinken in alles wat ik doe."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end
end
end_panel

