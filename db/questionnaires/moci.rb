# MOCI - Maudsley Obsessive-Compulsive Inventory

# Project ID 483
# Date (GMT) 06-12-2010 20:52:57
# All values between 1 and 8 auto-recoded with -1
# No manual recodes needed

key "moci"
title "Maudsley Obsessive-Compulsive Inventory (MOCI)"
description ""

panel do
 title "MOCI - Maudsley Obsessive-Compulsive Inventory"
 text "Bekijkt u alstublieft de volgende vragen en geef het antwoord dat het meest 
op u van toepassing is.

Ieder antwoord is goed, als het maar uw eigen mening weergeeft. Er zijn geen strikvragen. Werk vlot door en denk niet te lang na over de preciese betekenis van elke zin.

De vragen kunt u beantwoorden door uw keuze aan te klikken met de muis.

Klik op 'Volgende vraag' om verder te gaan."
end


panel do
question :v_1, :type => :radio do
  title "1. Ik vermijd het gebruik van openbare telefoons, omdat ik bang ben besmet te worden."
  description ""
  option :a1, :value => 0, :description => "Onjuist"
  option :a2, :value => 1, :description => "Juist"
end

question :v_2, :type => :radio do
  title "2. Ik heb vaak vervelende gedachten, die ik moeilijk uit mijn hoofd kan zetten."
  description ""
  option :a1, :value => 0, :description => "Onjuist"
  option :a2, :value => 1, :description => "Juist"
end

question :v_3, :type => :radio do
  title "3. Ik maak me meer dan andere mensen druk over eerlijkheid."
  description ""
  option :a1, :value => 0, :description => "Onjuist"
  option :a2, :value => 1, :description => "Juist"
end

question :v_4, :type => :radio do
  title "4. Ik ben vaak te laat, omdat ik alles maar niet op tijd af schijn te kunnen krijgen."
  description ""
  option :a1, :value => 0, :description => "Onjuist"
  option :a2, :value => 1, :description => "Juist"
end

question :v_5, :type => :radio do
  title "5. Als ik een dier aanraak, maak ik me bijzonder bezorgd over eventuele besmetting."
  description ""
  option :a1, :value => 0, :description => "Onjuist"
  option :a2, :value => 1, :description => "Juist"
end

question :v_6, :type => :radio do
  title "6. Ik moet vaak bepaalde dingen (zoals bijvoorbeeld gas, waterkranen, deuren enz.) meerdere malen controleren."
  description ""
  option :a1, :value => 0, :description => "Onjuist"
  option :a2, :value => 1, :description => "Juist"
end

question :v_7, :type => :radio do
  title "7. Ik heb een zeer streng geweten."
  description ""
  option :a1, :value => 0, :description => "Onjuist"
  option :a2, :value => 1, :description => "Juist"
end
end 
question :v_8, :type => :radio do
  title "8. Ik merk dat ik bijna elke dag geplaagd word door vervelende gedachten, die mij tegen mijn wil overvallen."
  description ""
  option :a1, :value => 0, :description => "Onjuist"
  option :a2, :value => 1, :description => "Juist"
end

question :v_9, :type => :radio do
  title "9. Als ik per ongeluk tegen iemand aanloop, maak ik me daar veel zorgen over."
  description ""
  option :a1, :value => 0, :description => "Onjuist"
  option :a2, :value => 1, :description => "Juist"
end

question :v_10, :type => :radio do
  title "10. Ik heb meestal ernstige twijfels over de gewone dagelijkse dingen die ik doe."
  description ""
  option :a1, :value => 0, :description => "Onjuist"
  option :a2, :value => 1, :description => "Juist"
end

question :v_11, :type => :radio do
  title "11. Mijn ouders waren vroeger beiden erg streng."
  description ""
  option :a1, :value => 0, :description => "Onjuist"
  option :a2, :value => 1, :description => "Juist"
end

question :v_12, :type => :radio do
  title "12. Ik raak snel achter met mijn werk, omdat ik sommige dingen telkens weer overdoe."
  description ""
  option :a1, :value => 0, :description => "Onjuist"
  option :a2, :value => 1, :description => "Juist"
end

question :v_13, :type => :radio do
  title "13. Ik gebruik slechts een normale hoeveelheid zeep."
  description ""
  option :a1, :value => 0, :description => "Juist"
  option :a2, :value => 1, :description => "Onjuist"
end

question :v_14, :type => :radio do
  title "14. Sommige getallen zijn echte ongeluksgetallen."
  description ""
  option :a1, :value => 0, :description => "Onjuist"
  option :a2, :value => 1, :description => "Juist"
end

question :v_15, :type => :radio do
  title "15. Ik controleer brieven ettelijke malen achter elkaar voordat ik ze op de post doe."
  description ""
  option :a1, :value => 0, :description => "Onjuist"
  option :a2, :value => 1, :description => "Juist"
end

question :v_16, :type => :radio do
  title "16. Ik heb veel tijd nodig om me 's morgens aan te kleden."
  description ""
  option :a1, :value => 0, :description => "Onjuist"
  option :a2, :value => 1, :description => "Juist"
end

question :v_17, :type => :radio do
  title "17. Ik maak me er overdreven druk over of iets wel of niet schoon is."
  description ""
  option :a1, :value => 0, :description => "Onjuist"
  option :a2, :value => 1, :description => "Juist"
end

question :v_18, :type => :radio do
  title "18. Een van mijn grootste problemen is dat ik teveel aandacht besteed aan details."
  description ""
  option :a1, :value => 0, :description => "Onjuist"
  option :a2, :value => 1, :description => "Juist"
end

question :v_19, :type => :radio do
  title "19. Ik kan zonder enige aarzeling gebruik maken van goed schoongehouden wc's."
  description ""
  option :a1, :value => 0, :description => "Juist"
  option :a2, :value => 1, :description => "Onjuist"
end

question :v_20, :type => :radio do
  title "20. Mijn grootste probleem is dat ik herhaaldelijk controleer."
  description ""
  option :a1, :value => 0, :description => "Onjuist"
  option :a2, :value => 1, :description => "Juist"
end

question :v_21, :type => :radio do
  title "21. Ik maak me veel zorgen over ziektekiemen en besmettelijke ziektes."
  description ""
  option :a1, :value => 0, :description => "Onjuist"
  option :a2, :value => 1, :description => "Juist"
end

question :v_22, :type => :radio do
  title "22. Ik heb de neiging dingen meer dan 'e'en keer te controleren."
  description ""
  option :a1, :value => 0, :description => "Onjuist"
  option :a2, :value => 1, :description => "Juist"
end

question :v_23, :type => :radio do
  title "23. Ik houd me aan een erg strak schema als ik gewone dingen doe."
  description ""
  option :a1, :value => 0, :description => "Onjuist"
  option :a2, :value => 1, :description => "Juist"
end

question :v_24, :type => :radio do
  title "24. Ik heb het gevoel dat mijn handen vies zijn nadat ik geld heb aangeraakt."
  description ""
  option :a1, :value => 0, :description => "Onjuist"
  option :a2, :value => 1, :description => "Juist"
end

question :v_25, :type => :radio do
  title "25. Ik heb de gewoonte om te tellen als ik gewone dagelijkse dingen doe."
  description ""
  option :a1, :value => 0, :description => "Onjuist"
  option :a2, :value => 1, :description => "Juist"
end

question :v_26, :type => :radio do
  title "26. Ik heb nogal wat tijd nodig om me 's morgens te wassen."
  description ""
  option :a1, :value => 0, :description => "Onjuist"
  option :a2, :value => 1, :description => "Juist"
end

question :v_27, :type => :radio do
  title "27. Ik gebruik erg veel ontsmettingsmiddelen."
  description ""
  option :a1, :value => 0, :description => "Onjuist"
  option :a2, :value => 1, :description => "Juist"
end

question :v_28, :type => :radio do
  title "28. Ik besteed elke dag veel tijd aan het telkens weer controleren van bepaalde dingen."
  description ""
  option :a1, :value => 0, :description => "Onjuist"
  option :a2, :value => 1, :description => "Juist"
end

question :v_29, :type => :radio do
  title "29. Ik heb veel tijd nodig om 's avonds mijn kleren te vouwen en op te hangen."
  description ""
  option :a1, :value => 0, :description => "Onjuist"
  option :a2, :value => 1, :description => "Juist"
end

question :v_30, :type => :radio do
  title "30. Zelfs als ik iets heel zorgvuldig doe, heb ik nog vaak het gevoel dat het niet helemaal goed is."
  description ""
  option :a1, :value => 0, :description => "Onjuist"
  option :a2, :value => 1, :description => "Juist"
end

end_panel

