title "Persoonlijkheid 1 (NEO-FFI-3) 'hoegekis.nl'"
short_description ""
description ""
outcome_description ""

abortable

default_question_options :required => true
#NEO-FFI-3, H.A. Hoekstra, J.Ormel en F. de Fruyt, (c) Hogrefe Uitgevers BV, (c)"


panel do
  title "Persoonlijkheid"
  text "Deze vragenlijst bevat 60 uitspraken. Lees elke uitspraak zorgvuldig. Klik de uitspraak aan die uw mening het beste
  weergeeft.
  Al uw antwoorden zullen anoniem worden verwerkt."

question :v_1, :type => :scale, :presentation => :horizontal do
  title "  1. Ik ben geen tobber."
  description ""
  option :a1, :value => 5, :description => "Helemaal oneens"
  option :a2, :value => 4, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 2, :description => "Eens"
  option :a5, :value => 1, :description => "Helemaal eens"
end

question :v_2, :type => :scale, :presentation => :horizontal do
  title "  2. Ik houd er van veel mensen om me heen te hebben."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_3, :type => :scale, :presentation => :horizontal do
  title "  3. Ik kan mij met plezier helemaal verliezen in een dagdroom of fantasie."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_4, :type => :scale, :presentation => :horizontal do
  title "  4. Ik probeer hoffelijk te zijn tegen iedereen die ik ontmoet."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_5, :type => :scale, :presentation => :horizontal do
  title "  5. Ik houd mijn spullen netjes en schoon."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_6, :type => :scale, :presentation => :horizontal do
  title "  6. Ik heb mij wel eens verbitterd en vervuld van wrok gevoeld."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_7, :type => :scale, :presentation => :horizontal do
  title "  7. Ik lach gemakkelijk."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_8, :type => :scale, :presentation => :horizontal do
  title "  8. Ik vind het interessant om met nieuwe hobby´s te  beginnen."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_9, :type => :scale, :presentation => :horizontal do
  title "  9. Wanneer ik ben beledigd, probeer ik het maar te vergeven en vergeten."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_10, :type => :scale, :presentation => :horizontal do
  title "  10. Ik kan mijzelf vrij goed oppeppen om dingen op tijd af te krijgen."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_11, :type => :scale, :presentation => :horizontal do
  title "  11. Wanneer ik onder grote spanning sta, heb ik soms het gevoel dat ik er aan onderdoor ga."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_12, :type => :scale, :presentation => :horizontal do
  title "  12. Ik geef de voorkeur aan werk dat ik alleen kan doen zonder gestoord te worden door anderen."
  description ""
  option :a1, :value => 5, :description => "Helemaal oneens"
  option :a2, :value => 4, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 2, :description => "Eens"
  option :a5, :value => 1, :description => "Helemaal eens"
end

question :v_13, :type => :scale, :presentation => :horizontal do
  title "  13. Ik ben geïntrigeerd door de patronen die ik vind in de kunst en de natuur."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_14, :type => :scale, :presentation => :horizontal do
  title "  14. Sommige mensen vinden mij zelfzuchtig en egoïstisch."
  description ""
  option :a1, :value => 5, :description => "Helemaal oneens"
  option :a2, :value => 4, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 2, :description => "Eens"
  option :a5, :value => 1, :description => "Helemaal eens"
end

question :v_15, :type => :scale, :presentation => :horizontal do
  title "  15. Ik kom vaak in situaties terecht waar ik niet goed op voorbereid ben."
  description ""
  option :a1, :value => 5, :description => "Helemaal oneens"
  option :a2, :value => 4, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 2, :description => "Eens"
  option :a5, :value => 1, :description => "Helemaal eens"
end

question :v_16, :type => :scale, :presentation => :horizontal do
  title "  16. Ik voel me zelden eenzaam of triest."
  description ""
  option :a1, :value => 5, :description => "Helemaal oneens"
  option :a2, :value => 4, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 2, :description => "Eens"
  option :a5, :value => 1, :description => "Helemaal eens"
end

question :v_17, :type => :scale, :presentation => :horizontal do
  title "  17. Ik vind het echt leuk om met mensen te praten."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_18, :type => :scale, :presentation => :horizontal do
  title "  18. Ik vind dat leerlingen alleen maar in verwarring worden gebracht door ze te laten luisteren naar sprekers met afwijkende ideeën."
  description ""
  option :a1, :value => 5, :description => "Helemaal oneens"
  option :a2, :value => 4, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 2, :description => "Eens"
  option :a5, :value => 1, :description => "Helemaal eens"
end

question :v_19, :type => :scale, :presentation => :horizontal do
  title "  19. Als iemand strijd met mij zoekt, sta ik klaar om terug te vechten."
  description ""
  option :a1, :value => 5, :description => "Helemaal oneens"
  option :a2, :value => 4, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 2, :description => "Eens"
  option :a5, :value => 1, :description => "Helemaal eens"
end

question :v_20, :type => :scale, :presentation => :horizontal do
  title "  20. Ik probeer alle aan mij opgedragen taken gewetensvol uit te voeren."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end
end

panel do
question :v_21, :type => :scale, :presentation => :horizontal do
  title "  21. Ik voel me vaak gespannen en zenuwachtig."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_22, :type => :scale, :presentation => :horizontal do
  title "  22. Ik ben graag daar waar wat te beleven valt."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_23, :type => :scale, :presentation => :horizontal do
  title "  23. Poëzie doet mij weinig tot niets."
  description ""
  option :a1, :value => 5, :description => "Helemaal oneens"
  option :a2, :value => 4, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 2, :description => "Eens"
  option :a5, :value => 1, :description => "Helemaal eens"
end

question :v_24, :type => :scale, :presentation => :horizontal do
  title "  24. Ik denk meestal het beste van mensen."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_25, :type => :scale, :presentation => :horizontal do
  title "  25. Ik heb duidelijke doelen voor ogen en werk daar op een systematische manier naar toe."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_26, :type => :scale, :presentation => :horizontal do
  title "  26. Soms voel ik me volkomen waardeloos."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_27, :type => :scale, :presentation => :horizontal do
  title "  27. Ik ga mensenmenigtes uit de weg."
  description ""
  option :a1, :value => 5, :description => "Helemaal oneens"
  option :a2, :value => 4, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 2, :description => "Eens"
  option :a5, :value => 1, :description => "Helemaal eens"
end

question :v_28, :type => :scale, :presentation => :horizontal do
  title "  28. Ik ken een breed scala van emoties en gevoelens."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_29, :type => :scale, :presentation => :horizontal do
  title "  29. Ik ben beter dan de meeste mensen, en dat weet ik ook."
  description ""
  option :a1, :value => 5, :description => "Helemaal oneens"
  option :a2, :value => 4, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 2, :description => "Eens"
  option :a5, :value => 1, :description => "Helemaal eens"
end

question :v_30, :type => :scale, :presentation => :horizontal do
  title "  30. Ik verknoei veel tijd voordat ik echt aan het werk ga."
  description ""
  option :a1, :value => 5, :description => "Helemaal oneens"
  option :a2, :value => 4, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 2, :description => "Eens"
  option :a5, :value => 1, :description => "Helemaal eens"
end

question :v_31, :type => :scale, :presentation => :horizontal do
  title "  31. Ik voel me zelden angstig of zorgelijk."
  description ""
  option :a1, :value => 5, :description => "Helemaal oneens"
  option :a2, :value => 4, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 2, :description => "Eens"
  option :a5, :value => 1, :description => "Helemaal eens"
end

question :v_32, :type => :scale, :presentation => :horizontal do
  title "  32. Ik voel me vaak alsof ik barst van energie."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_33, :type => :scale, :presentation => :horizontal do
  title "  33. Ik merk zelden de stemmingen of gevoelens op, die verschillende omgevingen oproepen."
  description ""
  option :a1, :value => 5, :description => "Helemaal oneens"
  option :a2, :value => 4, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 2, :description => "Eens"
  option :a5, :value => 1, :description => "Helemaal eens"
end

question :v_34, :type => :scale, :presentation => :horizontal do
  title "  34. Soms dreig ik mensen of vlei ik ze, zodat ze doen wat ik wil."
  description ""
  option :a1, :value => 5, :description => "Helemaal oneens"
  option :a2, :value => 4, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 2, :description => "Eens"
  option :a5, :value => 1, :description => "Helemaal eens"
end

question :v_35, :type => :scale, :presentation => :horizontal do
  title "  35. Ik werk hard om mijn doelen te bereiken."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_36, :type => :scale, :presentation => :horizontal do
  title "  36. Ik word vaak kwaad om de manier waarop mensen me behandelen."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_37, :type => :scale, :presentation => :horizontal do
  title "  37. Ik ben een vrolijk en levendig iemand."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_38, :type => :scale, :presentation => :horizontal do
  title "  38. Ik zou het moeilijk vinden om mijn gedachten zomaar te laten dwalen."
  description ""
  option :a1, :value => 5, :description => "Helemaal oneens"
  option :a2, :value => 4, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 2, :description => "Eens"
  option :a5, :value => 1, :description => "Helemaal eens"
end

question :v_39, :type => :scale, :presentation => :horizontal do
  title "  39. Sommige mensen vinden mij koel en berekenend."
  description ""
  option :a1, :value => 5, :description => "Helemaal oneens"
  option :a2, :value => 4, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 2, :description => "Eens"
  option :a5, :value => 1, :description => "Helemaal eens"
end

question :v_40, :type => :scale, :presentation => :horizontal do
  title "  40. Als ik iets beloof, kan men er op rekenen dat ik die belofte ook nakom."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end
end

panel do
question :v_41, :type => :scale, :presentation => :horizontal do
  title "  41. Wanneer dingen mis gaan raak ik maar al te vaak ontmoedigd en heb ik zin om het op te geven."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_42, :type => :scale, :presentation => :horizontal do
  title "  42. Ik vind het niet erg leuk om zomaar een praatje met iemand te maken."
  description ""
  option :a1, :value => 5, :description => "Helemaal oneens"
  option :a2, :value => 4, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 2, :description => "Eens"
  option :a5, :value => 1, :description => "Helemaal eens"
end

question :v_43, :type => :scale, :presentation => :horizontal do
  title "  43. Wanneer ik een gedicht lees of naar een kunstwerk kijk, voel ik soms een koude rilling of een golf van opwinding."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_44, :type => :scale, :presentation => :horizontal do
  title "  44. Ik heb geen sympathie voor bedelaars."
  description ""
  option :a1, :value => 5, :description => "Helemaal oneens"
  option :a2, :value => 4, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 2, :description => "Eens"
  option :a5, :value => 1, :description => "Helemaal eens"
end

question :v_45, :type => :scale, :presentation => :horizontal do
  title "  45. Soms ben ik niet zo betrouwbaar als ik zou moeten zijn."
  description ""
  option :a1, :value => 5, :description => "Helemaal oneens"
  option :a2, :value => 4, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 2, :description => "Eens"
  option :a5, :value => 1, :description => "Helemaal eens"
end

question :v_46, :type => :scale, :presentation => :horizontal do
  title "  46. Ik ben zelden verdrietig of depressief."
  description ""
  option :a1, :value => 5, :description => "Helemaal oneens"
  option :a2, :value => 4, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 2, :description => "Eens"
  option :a5, :value => 1, :description => "Helemaal eens"
end

question :v_47, :type => :scale, :presentation => :horizontal do
  title "  47. Ik heb een jachtig leven."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_48, :type => :scale, :presentation => :horizontal do
  title "  48. Ik ben niet erg geïnteresseerd in het speculeren over het wezen van het universum of van de mens."
  description ""
  option :a1, :value => 5, :description => "Helemaal oneens"
  option :a2, :value => 4, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 2, :description => "Eens"
  option :a5, :value => 1, :description => "Helemaal eens"
end

question :v_49, :type => :scale, :presentation => :horizontal do
  title "  49. Over het algemeen probeer ik attent en zorgzaam te zijn."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_50, :type => :scale, :presentation => :horizontal do
  title "  50. Ik ben een productief mens die een klus altijd voor elkaar krijgt."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_51, :type => :scale, :presentation => :horizontal do
  title "  51. Ik voel me vaak hulpeloos en wil dan graag dat iemand anders mijn problemen oplost."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_52, :type => :scale, :presentation => :horizontal do
  title "  52. Ik ben een heel actief persoon."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_53, :type => :scale, :presentation => :horizontal do
  title "  53. Ik ben erg leergierig."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_54, :type => :scale, :presentation => :horizontal do
  title "  54. Als ik mensen niet mag, laat ik dat ook merken."
  description ""
  option :a1, :value => 5, :description => "Helemaal oneens"
  option :a2, :value => 4, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 2, :description => "Eens"
  option :a5, :value => 1, :description => "Helemaal eens"
end

question :v_55, :type => :scale, :presentation => :horizontal do
  title "  55. Het lijkt mij maar niet te lukken om de dingen goed op orde te hebben."
  description ""
  option :a1, :value => 5, :description => "Helemaal oneens"
  option :a2, :value => 4, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 2, :description => "Eens"
  option :a5, :value => 1, :description => "Helemaal eens"
end

question :v_56, :type => :scale, :presentation => :horizontal do
  title "  56. Soms schaam ik me zo dat ik wel door de grond wil zakken."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_57, :type => :scale, :presentation => :horizontal do
  title "  57. Ik ga liever mijn eigen gang dan dat ik leiding geef aan anderen."
  description ""
  option :a1, :value => 5, :description => "Helemaal oneens"
  option :a2, :value => 4, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 2, :description => "Eens"
  option :a5, :value => 1, :description => "Helemaal eens"
end

question :v_58, :type => :scale, :presentation => :horizontal do
  title "  58. Ik heb vaak plezier in het spelen met theorieën of abstracte ideeën."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end

question :v_59, :type => :scale, :presentation => :horizontal do
  title "  59. Als het nodig is ben ik bereid om mensen te manipuleren om te krijgen wat ik wil."
  description ""
  option :a1, :value => 5, :description => "Helemaal oneens"
  option :a2, :value => 4, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 2, :description => "Eens"
  option :a5, :value => 1, :description => "Helemaal eens"
end

question :v_60, :type => :scale, :presentation => :horizontal do
  title "  60. Ik streef er naar uit te blinken in alles wat ik doe."
  description ""
  option :a1, :value => 1, :description => "Helemaal oneens"
  option :a2, :value => 2, :description => "Oneens"
  option :a3, :value => 3, :description => "Neutraal"
  option :a4, :value => 4, :description => "Eens"
  option :a5, :value => 5, :description => "Helemaal eens"
end
end

score :neu, :label => "Neuroticisme" do
  neu = sum(values_with_nils(:v_1, :v_6, :v_11, :v_16, :v_21, :v_26, :v_31, :v_36, :v_41, :v_46, :v_51, :v_56))
  # berekenen neuroticisme normscore vrouwen en mannen
  if neu >= 47
     neu_norm  = "Zeer hoog"
  elsif neu >= 42
     neu_norm =  "Hoog"
  elsif neu >= 37
     neu_norm = "Tamelijk hoog"
  elsif neu >= 33
     neu_norm = "Gemiddeld hoog"
  elsif neu >= 29
     neu_norm = "Gemiddeld"
  elsif neu >= 25
     neu_norm = "Gemiddeld laag"
  elsif neu >= 22
     neu_norm = "Tamelijk laag"
  elsif neu >= 18
     neu_norm = "Laag"
  else
     neu_norm = "Zeer laag"
  end
  {
    :label => "Neuroticisme",
    :value => neu,
    :norm => neu_norm
  }
end

score :ext, :label => "Extraversie" do
  ext = sum(values_with_nils(:v_2, :v_7, :v_12, :v_17, :v_22, :v_27, :v_32, :v_37, :v_42, :v_47, :v_52, :v_57))
  # berekenen extraversie normscore vrouwen en mannen
  if ext >= 52
     ext_norm = "Zeer hoog"
  elsif ext >= 49
     ext_norm = "Hoog"
  elsif ext >= 46
     ext_norm = "Tamelijk hoog"
  elsif ext >= 42
     ext_norm = "Gemiddeld hoog"
  elsif ext >= 39
     ext_norm = "Gemiddeld"
  elsif ext >= 36
     ext_norm = "Gemiddeld laag"
  elsif ext >= 33
     ext_norm = "Tamelijk laag"
  elsif ext >= 29
     ext_norm = "Laag"
  else
     ext_norm = "Zeer laag"
  end
  {
    :label => "Extraversie",
    :value => ext,
    :norm => ext_norm
  }
end

score :ope, :label => "Openheid" do
  ope = sum(values_with_nils(:v_3, :v_8, :v_13, :v_18, :v_23, :v_28, :v_33, :v_38, :v_43, :v_48, :v_53, :v_58))
   # berekenen openheid normscore voor mannen en vrouwen
  if ope >= 49
     ope_norm = "Zeer hoog"
  elsif ope >= 45
     ope_norm = "Hoog"
  elsif ope >= 41
     ope_norm = "Tamelijk hoog"
  elsif ope >= 37
     ope_norm = "Gemiddeld hoog"
  elsif ope >= 34
     ope_norm = "Gemiddeld"
  elsif ope >= 32
     ope_norm = "Gemiddeld laag"
  elsif ope >= 29
     ope_norm = "Tamelijk laag"
  elsif ope >= 26
     ope_norm = "Laag"
  else
     ope_norm = "Zeer laag"
  end
  {
    :label => "Openheid",
    :value =>  ope,
    :norm => ope_norm
  }
end

score :alt, :label => "Altruïsme" do
  alt = sum(values_with_nils(:v_4, :v_9, :v_14, :v_19, :v_24, :v_29, :v_34, :v_39, :v_44, :v_49, :v_54, :v_59))
   # berekenen altruisme normscore voor mannen en vrouwen
  if alt >= 54
     alt_norm = "Zeer hoog"
  elsif alt >= 51
     alt_norm = "Hoog"
  elsif alt >= 48
     alt_norm = "Tamelijk hoog"
  elsif alt >= 46
     alt_norm = "Gemiddeld hoog"
  elsif alt >= 43
     alt_norm = "Gemiddeld"
  elsif alt >= 41
     alt_norm = "Gemiddeld laag"
  elsif alt >= 38
     alt_norm = "Tamelijk laag"
  elsif alt >= 35
     alt_norm = "Laag"
  else
     alt_norm = "Zeer laag"
  end
  {
    :label => "Altruïsme",
    :value =>  alt,
    :norm => alt_norm
  }
end

score :con, :label => "Consciëntieusheid" do
  con = sum(values_with_nils(:v_5, :v_10, :v_15, :v_20, :v_25, :v_30, :v_35, :v_40, :v_45, :v_50, :v_55, :v_60))
   # berekenen consciëntieusheid normscore voor mannen en vrouwen
  if con >= 55
     con_norm = "Zeer hoog"
  elsif con >= 53
     con_norm = "Hoog"
  elsif con >= 50
     con_norm = "Tamelijk hoog"
  elsif con >= 47
     con_norm = "Gemiddeld hoog"
  elsif con >= 45
     con_norm = "Gemiddeld"
  elsif con >= 42
     con_norm = "Gemiddeld laag"
  elsif con >= 39
     con_norm = "Tamelijk laag"
  elsif con >= 36
     con_norm = "Laag"
  else
     con_norm = "Zeer laag"
  end
  {
    :label => "Consciëntieusheid",
    :value =>  con,
    :norm => con_norm
  }
end
