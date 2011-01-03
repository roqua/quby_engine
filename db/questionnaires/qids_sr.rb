# QIDS-SR

# Project ID 608
# Date (GMT) 06-12-2010 20:55:16
# All values between 1 and 8 auto-recoded with -1
# No manual recodes needed

key "qids_sr"
title "QIDS-SR"
description ""

panel do
 title "Korte Zelfinvullijst Depressieve Symptomen"
 text "De bedoeling van deze vragenlijst is om meer inzicht te krijgen in een aantal aspecten van uw stemming. 

De vragenlijst bevat 16 vragen. 

Vink bij elke vraag het antwoord aan dat *de afgelopen zeven dagen* het meest op u van toepassing was.

Klik op 'Volgende vraag' om verder te gaan."
end

panel do
question :v_1, :type => :radio do
  title "1. In slaap vallen:"
  description ""
  option :a1, :value => 0, :description => "Het duurt nooit langer dan 30 minuten om in slaap te vallen"
  option :a2, :value => 1, :description => "Het duurt tenminste 30 minuten om in slaap te vallen, minder dan de helft van de week"
  option :a3, :value => 2, :description => "Het duurt tenminste 30 minuten om in slaap te vallen, meer dan de helft van de week"
  option :a4, :value => 3, :description => "Het duurt meer dan 60 minuten om in slaap te vallen, meer dan de helft van de week"
end

question :v_2, :type => :radio do
  title "2. Slaap gedurende de nacht:"
  description ""
  option :a1, :value => 0, :description => "Ik word 's nachts niet wakker"
  option :a2, :value => 1, :description => "Ik slaap onrustig en licht en word een aantal keren per nacht even wakker"
  option :a3, :value => 2, :description => "Ik ben tenminste 'e'en keer per nacht klaar wakker, maar val weer gemakkelijk in slaap"
  option :a4, :value => 3, :description => "Ik word vaker dan 'e'en keer per nacht wakker en blijf dan 20 minuten of langer wakker, meer dan de helft van de week"
end

question :v_3, :type => :radio do
  title "3. Te vroeg wakker worden:"
  description ""
  option :a1, :value => 0, :description => "Meestal word ik niet eerder dan 30 minuten voordat ik op moet staan, wakker"
  option :a2, :value => 1, :description => "Ik word meer dan 30 minuten voordat ik op moet staan wakker, meer dan de helft van de tijd"
  option :a3, :value => 2, :description => "Ik word tenminste 1 uur voordat ik op moet staan wakker, meer dan de helft van de tijd"
  option :a4, :value => 3, :description => "Ik word tenminste 2 uur voordat ik op moet staan wakker, meer dan de helft van de tijd"
end

question :v_4, :type => :radio do
  title "4. Te veel slapen:"
  description ""
  option :a1, :value => 0, :description => "Ik slaap niet langer dan 7-8 uur per nacht, zonder overdag een dutje te doen"
  option :a2, :value => 1, :description => "Ik slaap niet langer dan 10 uur binnen 'e'en etmaal (inclusief dutten)"
  option :a3, :value => 2, :description => "Ik slaap niet langer dan 12 uur binnen 'e'en etmaal (inclusief dutten)"
  option :a4, :value => 3, :description => "Ik slaap langer dan 12 uur binnen 'e'en etmaal (inclusief dutten)"
end
end

panel do
question :v_5, :type => :radio do
  title "5. Somber voelen:"
  description ""
  option :a1, :value => 0, :description => "Ik ben niet somber"
  option :a2, :value => 1, :description => "Ik ben minder dan de helft van de tijd somber"
  option :a3, :value => 2, :description => "Ik ben meer dan de helft van de tijd somber"
  option :a4, :value => 3, :description => "Ik ben bijna altijd somber"
end

question :v_13, :type => :radio do
  title "6. Verminderde eetlust:"
  description ""
  option :a1, :value => 0, :description => "Mijn eetlust is niet anders dan gewoonlijk"
  option :a2, :value => 1, :description => "Ik eet wat minder vaak of kleinere hoeveelheden dan gewoonlijk"
  option :a3, :value => 2, :description => "Ik eet veel minder dan gewoonlijk en alleen met inspanning"
  option :a4, :value => 3, :description => "Ik eet nauwelijks binnen een etmaal en alleen met extreme inspanning of op aandringen van anderen"
end

question :v_36, :type => :radio do
  title "7. Toegenomen eetlust:"
  description ""
  option :a1, :value => 0, :description => "Mijn eetlust is niet anders dan gewoonlijk"
  option :a2, :value => 1, :description => "Ik voel vaker dan gewoonlijk de behoefte om te eten"
  option :a3, :value => 2, :description => "Ik eet regelmatig vaker en grotere hoeveelheden dan gewoonlijk"
  option :a4, :value => 3, :description => "Ik voel een sterke neiging om tijdens en tussen de maaltijden door te veel te eten"
end

question :v_15, :type => :radio do
  title "8. Gewichtsafname gedurende de afgelopen 2 weken:"
  description ""
  option :a1, :value => 0, :description => "Geen gewichtsverandering"
  option :a2, :value => 1, :description => "Ik heb het gevoel dat ik wat ben afgevallen"
  option :a3, :value => 2, :description => "Ik ben 1 kg of meer afgevallen"
  option :a4, :value => 3, :description => "Ik ben 2 1/2 kg of meer afgevallen"
end
end

panel do
question :v_37, :type => :radio do
  title "9. Gewichtstoename gedurende de afgelopen 2 weken:"
  description ""
  option :a1, :value => 0, :description => "Geen gewichtsverandering"
  option :a2, :value => 1, :description => "Ik heb het gevoel dat ik wat ben aangekomen"
  option :a3, :value => 2, :description => "Ik ben 1 kg of meer aangekomen"
  option :a4, :value => 3, :description => "Ik ben 2 1/2 kg of meer aangekomen"
end

question :v_17, :type => :radio do
  title "10. Concentratie / besluitvaardigheid:"
  description ""
  option :a1, :value => 0, :description => "Er is geen verandering in gebruikelijke concentratievermogen of in besluitvaardigheid"
  option :a2, :value => 1, :description => "Ik voel mij nu en dan besluiteloos of merk dat ik mijn aandacht er niet bij kan houden"
  option :a3, :value => 2, :description => "Ik heb bijna altijd grote moeite om mijn aandacht vast te houden en om beslissingen te nemen"
  option :a4, :value => 3, :description => "Ik kan mij niet goed genoeg concentreren om te lezen of kan zelfs niet de kleinste beslissingen nemen"
end

question :v_18, :type => :radio do
  title "11. Zelfbeeld:"
  description ""
  option :a1, :value => 0, :description => "Ik vind mijzelf even waardevol en nuttig als een ander"
  option :a2, :value => 1, :description => "maak mijzelf meer verwijten dan gewoonlijk"
  option :a3, :value => 2, :description => "Ik heb sterk de indruk dat ik anderen in moeilijkheden breng"
  option :a4, :value => 3, :description => "Ik denk voortdurend aan mijn grotere en kleinere tekortkomingen"
end

question :v_20, :type => :radio do
  title "12. Gedachten aan dood en zelfmoord:"
  description ""
  option :a1, :value => 0, :description => "Ik denk niet aan zelfmoord of aan de dood"
  option :a2, :value => 1, :description => "Ik heb het gevoel dat mijn leven leeg is en vraag me af of het nog de moeite waard is"
  option :a3, :value => 2, :description => "Ik denk enkele malen per week wel even aan zelfmoord of aan de dood"
  option :a4, :value => 3, :description => "Ik denk een aantal keren per dag serieus na over zelfmoord of de dood, 'of ik heb zelfmoordplannen gemaakt, 'of ik heb al een poging gedaan om mijn leven te be'eindigen"
end
end

panel do
question :v_21, :type => :radio do
  title "13. Algemene interesse:"
  description ""
  option :a1, :value => 0, :description => "Geen verandering van mijn normale interesse in andere mensen en activiteiten"
  option :a2, :value => 1, :description => "Ik merk dat ik minder ge'interesseerd ben in anderen en in activiteiten"
  option :a3, :value => 2, :description => "Ik heb alleen nog interesse in 'e'en of twee dingen die ik voorheen deed"
  option :a4, :value => 3, :description => "Ik heb vrijwel geen interesse meer in dingen die ik voorheen deed"
end

question :v_22, :type => :radio do
  title "14. Energie:"
  description ""
  option :a1, :value => 0, :description => "Geen verandering in mijn gebruikelijke energie"
  option :a2, :value => 1, :description => "Ik word sneller moe dan gewoonlijk"
  option :a3, :value => 2, :description => "Ik heb grote moeite met het beginnen aan of volhouden van gebruikelijke dagelijkse activiteiten (bijvoorbeeld boodschappen doen, huiswerk, koken, of naar het werk gaan)"
  option :a4, :value => 3, :description => "Ik ben niet in staat om mijn normale dagelijkse activiteiten uit te voeren vanwege een gebrek aan energie"
end

question :v_25, :type => :radio do
  title "15. Gevoel van traagheid:"
  description ""
  option :a1, :value => 0, :description => "Ik denk, spreek en beweeg in mijn normale tempo"
  option :a2, :value => 1, :description => "Mijn denken is vertraagd en mijn stem klinkt vlak en saai"
  option :a3, :value => 2, :description => "Ik heb enkele seconden nodig om te antwoorden op vragen, en mijn denken is zeker vertraagd"
  option :a4, :value => 3, :description => "Het kost me zeker veel moeite om te reageren op vragen"
end

question :v_26, :type => :radio do
  title "16. Rusteloos gevoel:"
  description ""
  option :a1, :value => 0, :description => "Ik voel mij niet rusteloos"
  option :a2, :value => 1, :description => "Ik ben vaak zenuwachtig, ik wring met mijn handen en ik kan niet rustig op een stoel zitten"
  option :a3, :value => 2, :description => "Ik heb de neiging te bewegen en ben nogal rusteloos"
  option :a4, :value => 3, :description => "Ik kan vaak niet stilzitten en loop dan te ijsberen"
end
end
end_panel

