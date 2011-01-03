# EDE-Q Vragenlijst

# Project ID 498
# Date (GMT) 06-12-2010 20:44:19
# All values between 1 and 8 auto-recoded with -1
# Manual recodes: 16,32,34,36,38,40,42:+1 en daarna 2

key "ede-q"
title "De EDE-Q Vragenlijst"
description ""

panel do
 title "De EDE-Q Vragenlijst"
 text "De bedoeling van deze vragenlijst is om beter inzicht te krijgen in jouw eetgewoonten en opvattingen.

Lees elke vraag aandachtig door. Bij de meeste vragen wordt verzocht een hokje aan te vinken. Vink vervolgens één hokje aan dat het beste bij jou past. Er zijn geen goede of foute antwoorden, dus probeer zo eerlijk mogelijk te zijn in je antwoorden. Sla alsjeblieft geen vragen over.

Alle vragen hebben alleen betrekking op de *afgelopen 28 dagen (4 weken)*. Wij doen dus een beroep op jouw geheugen. Probeer toch zo nauwkeurig mogelijk het antwoord te schatten. Het is zeer raadzaam om tijdens het invullen van deze vragenlijst *een agenda of een kalender met daarop aantekeningen van jouw bezigheden* erbij te houden. Ga vanaf vandaag 28 dagen terug en markeer deze periode in je agenda of kalender.

Deze vragenlijst bevat 30 vragen.

Klik op 'Volgende vraag' om verder te gaan."
end

panel do
question :v_1, :type => :radio do
  title "1. Hoeveel dagen van de 28 dagen heb je bewust geprobeerd minder te eten om je figuur of gewicht te be'invloeden? Los van of het gelukt is of niet."
  option :a1, :value => 0, :description => "0 dagen"
  option :a2, :value => 1, :description => "1 - 5 dagen"
  option :a3, :value => 2, :description => "6 - 12 dagen"
  option :a4, :value => 3, :description => "13 - 15 dagen"
  option :a5, :value => 4, :description => "16 - 22 dagen"
  option :a6, :value => 5, :description => "23 - 27 dagen"
  option :a7, :value => 6, :description => "28 dagen"
end

question :v_2, :type => :radio do
  title "2. Hoeveel dagen van de 28 dagen heb je, terwijl je wakker was, 8 uren of langer achter elkaar niets gegeten om je figuur of gewicht te be'invloeden?"
  option :a1, :value => 0, :description => "0 dagen"
  option :a2, :value => 1, :description => "1 - 5 dagen"
  option :a3, :value => 2, :description => "6 - 12 dagen"
  option :a4, :value => 3, :description => "13 - 15 dagen"
  option :a5, :value => 4, :description => "16 - 22 dagen"
  option :a6, :value => 5, :description => "23 - 27 dagen"
  option :a7, :value => 6, :description => "28 dagen"
end
question :v_3, :type => :radio do
  title "3. Hoeveel dagen van de 28 dagen heb je geprobeerd voedsel dat je lekker vindt niet te eten omje figuur of gewicht te be'invloeden. Los van of het gelukt is of niet."
  option :a1, :value => 0, :description => "0 dagen"
  option :a2, :value => 1, :description => "1 - 5 dagen"
  option :a3, :value => 2, :description => "6 - 12 dagen"
  option :a4, :value => 3, :description => "13 - 15 dagen"
  option :a5, :value => 4, :description => "16 - 22 dagen"
  option :a6, :value => 5, :description => "23 - 27 dagen"
  option :a7, :value => 6, :description => "28 dagen"
end
end

panel do
question :v_4, :type => :radio do
  title "4. Hoeveel dagen van de 28 dagen heb je geprobeerd bepaalde eetregels te volgen om je gewicht te be'invloeden? Bijv. door slechts een beperkte hoeveelheid voedsel te eten of door een bepaald soort voedsel te eten."
  option :a1, :value => 0, :description => "0 dagen"
  option :a2, :value => 1, :description => "1 - 5 dagen"
  option :a3, :value => 2, :description => "6 - 12 dagen"
  option :a4, :value => 3, :description => "13 - 15 dagen"
  option :a5, :value => 4, :description => "16 - 22 dagen"
  option :a6, :value => 5, :description => "23 - 27 dagen"
  option :a7, :value => 6, :description => "28 dagen"
end
question :v_5, :type => :radio do
  title "5. Hoeveel dagen van de 28 dagen heb je gewild dat je maag helemaal leeg was?"
  option :a1, :value => 0, :description => "0 dagen"
  option :a2, :value => 1, :description => "1 - 5 dagen"
  option :a3, :value => 2, :description => "6 - 12 dagen"
  option :a4, :value => 3, :description => "13 - 15 dagen"
  option :a5, :value => 4, :description => "16 - 22 dagen"
  option :a6, :value => 5, :description => "23 - 27 dagen"
  option :a7, :value => 6, :description => "28 dagen"
end
question :v_6, :type => :radio do
  title "6. Hoeveel dagen van de 28 dagen heeft het denken over voedsel of calorie'en het je moeilijk gemaakt om je te kunnen concentreren op dingen waarin je ge'interesseerd bent?"
  option :a1, :value => 0, :description => "0 dagen"
  option :a2, :value => 1, :description => "1 - 5 dagen"
  option :a3, :value => 2, :description => "6 - 12 dagen"
  option :a4, :value => 3, :description => "13 - 15 dagen"
  option :a5, :value => 4, :description => "16 - 22 dagen"
  option :a6, :value => 5, :description => "23 - 27 dagen"
  option :a7, :value => 6, :description => "28 dagen"
end
end

panel do
question :v_7, :type => :radio do
  title "7. Hoeveel dagen van de 28 dagen ben je bang geweest om de controle over je eetgedrag te verliezen?"
  option :a1, :value => 0, :description => "0 dagen"
  option :a2, :value => 1, :description => "1 - 5 dagen"
  option :a3, :value => 2, :description => "6 - 12 dagen"
  option :a4, :value => 3, :description => "13 - 15 dagen"
  option :a5, :value => 4, :description => "16 - 22 dagen"
  option :a6, :value => 5, :description => "23 - 27 dagen"
  option :a7, :value => 6, :description => "28 dagen"
end

question :v_8, :type => :radio do
  title "8. Hoeveel dagen van de 28 dagen heb je eetbuien gehad?"
  option :a1, :value => 0, :description => "0 dagen"
  option :a2, :value => 1, :description => "1 - 5 dagen"
  option :a3, :value => 2, :description => "6 - 12 dagen"
  option :a4, :value => 3, :description => "13 - 15 dagen"
  option :a5, :value => 4, :description => "16 - 22 dagen"
  option :a6, :value => 5, :description => "23 - 27 dagen"
  option :a7, :value => 6, :description => "28 dagen"
end
question :v_9, :type => :radio do
  title "9. Hoeveel dagen van de 28 dagen heb je stiekem gegeten? (tel daarbij evt. eetbuien niet mee)"
  option :a1, :value => 0, :description => "0 dagen"
  option :a2, :value => 1, :description => "1 - 5 dagen"
  option :a3, :value => 2, :description => "6 - 12 dagen"
  option :a4, :value => 3, :description => "13 - 15 dagen"
  option :a5, :value => 4, :description => "16 - 22 dagen"
  option :a6, :value => 5, :description => "23 - 27 dagen"
  option :a7, :value => 6, :description => "28 dagen"
end
end

panel do
question :v_10, :type => :radio do
  title "10. Hoeveel dagen van de 28 dagen heb je een sterke wens gehad dat je buik helemaal plat was?"
  option :a1, :value => 0, :description => "0 dagen"
  option :a2, :value => 1, :description => "1 - 5 dagen"
  option :a3, :value => 2, :description => "6 - 12 dagen"
  option :a4, :value => 3, :description => "13 - 15 dagen"
  option :a5, :value => 4, :description => "16 - 22 dagen"
  option :a6, :value => 5, :description => "23 - 27 dagen"
  option :a7, :value => 6, :description => "28 dagen"
end

question :v_11, :type => :radio do
  title "11. Hoeveel dagen van de 28 dagen heeft het denken over je lichaam of gewicht het moeilijk gemaakt om je te kunnen concentreren op dingen waarin je ge'interesseerd bent?"
  option :a1, :value => 0, :description => "0 dagen"
  option :a2, :value => 1, :description => "1 - 5 dagen"
  option :a3, :value => 2, :description => "6 - 12 dagen"
  option :a4, :value => 3, :description => "13 - 15 dagen"
  option :a5, :value => 4, :description => "16 - 22 dagen"
  option :a6, :value => 5, :description => "23 - 27 dagen"
  option :a7, :value => 6, :description => "28 dagen"
end
question :v_12, :type => :radio do
  title "12. Hoeveel dagen van de 28 dagen heb je angst gehad om in gewicht aan te komen?"
  option :a1, :value => 0, :description => "0 dagen"
  option :a2, :value => 1, :description => "1 - 5 dagen"
  option :a3, :value => 2, :description => "6 - 12 dagen"
  option :a4, :value => 3, :description => "13 - 15 dagen"
  option :a5, :value => 4, :description => "16 - 22 dagen"
  option :a6, :value => 5, :description => "23 - 27 dagen"
  option :a7, :value => 6, :description => "28 dagen"
end
end

panel do
question :v_13, :type => :radio do
  title "13. Hoeveel dagen van de 28 dagen heb je je dik gevoeld?"
  option :a1, :value => 0, :description => "0 dagen"
  option :a2, :value => 1, :description => "1 - 5 dagen"
  option :a3, :value => 2, :description => "6 - 12 dagen"
  option :a4, :value => 3, :description => "13 - 15 dagen"
  option :a5, :value => 4, :description => "16 - 22 dagen"
  option :a6, :value => 5, :description => "23 - 27 dagen"
  option :a7, :value => 6, :description => "28 dagen"
end

question :v_14, :type => :radio do
  title "14. Hoeveel dagen van de 28 dagen heb je een sterke wens gehad om gewicht te verliezen?"
  option :a1, :value => 0, :description => "0 dagen"
  option :a2, :value => 1, :description => "1 - 5 dagen"
  option :a3, :value => 2, :description => "6 - 12 dagen"
  option :a4, :value => 3, :description => "13 - 15 dagen"
  option :a5, :value => 4, :description => "16 - 22 dagen"
  option :a6, :value => 5, :description => "23 - 27 dagen"
  option :a7, :value => 6, :description => "28 dagen"
end
question :v_15, :type => :radio do
  title "15. Hoe vaak in de afgelopen 28 dagen heb je je schuldig gevoeld na het eten?"
  option :a1, :value => 0, :description => "Nooit een schuldgevoel na het eten"
  option :a2, :value => 1, :description => "Bijna geen enkele keer een schuldgevoel na het eten"
  option :a3, :value => 2, :description => "Minder dan de helft van de keren een schuldgevoel na het eten"
  option :a4, :value => 3, :description => "De helft van de keren een schuldgevoel na het eten"
  option :a5, :value => 4, :description => "Meer dan de helft van de keren een schuldgevoel na het eten"
  option :a6, :value => 5, :description => "Bijna elke keer een schuldgevoel na het eten"
  option :a7, :value => 6, :description => "Elke keer een schuldgevoel na het eten"
end
end

panel do
question :v_16, :type => :radio do
  title "16. Heb je in de afgelopen 28 dagen wel eens binnen korte tijd een grote hoeveelheid gegeten?"
  option :a1, :value => 1, :description => "Ja" do
    question :v_16a, :type => :integer, :required => true do
      title "namelijk hoeveel keer?"
    end
  end
  option :a2, :value => 0, :description => "Nee"
end
end

question :v_17, :type => :radio do
  title "17. Heb je in de afgelopen 28 dagen daarbij (tijdens de eetepisodes van de vorige vraag) wel eens het gevoel gehad niet meer te kunnen voorkomen of controleren wat en hoeveel je at?"
  option :a1, :value => 1, :description => "Ja, namelijk %skeer"
  option :a2, :value => 0, :description => "Nee"
   
end

panel do
question :v_18, :type => :radio do
  title "18. Heb je in de afgelopen 28 dagen wel eens andere eetepisodes gehad, waarin je niet meer het gevoel had te kunnen voorkomen of controleren wat en hoeveel je at en daarbij geen grote hoeveelheid voedsel at?"
  option :a1, :value => 1, :description => "Ja, namelijk %skeer"
  option :a2, :value => 0, :description => "Nee"
end

question :v_19, :type => :radio do
  title "19. Heb je in de afgelopen 28 dagen gebraakt om gewichtstoename te voorkomen?"
  option :a1, :value => 1, :description => "Ja, namelijk %skeer"
  option :a2, :value => 0, :description => "Nee"
end

question :v_20, :type => :radio do
  title "20. Heb je de afgelopen 28 dagen laxeermiddelen geslikt om gewichtstoename te voorkomen?"
  option :a1, :value => 1, :description => "Ja, namelijk %skeer"
  option :a2, :value => 0, :description => "Nee"
end
end

panel do
question :v_21, :type => :radio do
  title "21. Heb je de afgelopen 28 dagen plasmiddelen gebruikt om gewichtstoename te voorkomen?"
    option :a1, :value => 1, :description => "Ja, namelijk %skeer"
  option :a2, :value => 0, :description => "Nee"
end

question :v_22, :type => :radio do
  title "22. Heb je de laatste 28 dagen meer dan een uur achter elkaar zeer intensief gesport om gewichtstoename te voorkomen?"
    option :a1, :value => 1, :description => "Ja, namelijk %skeer"
  option :a2, :value => 0, :description => "Nee"
end

question :v_23, :type => :radio do
  title "23. In de afgelopen 28 dagen: is je gewicht van invloed geweest op hoe je over jezelf dacht?"
  option :a1, :value => 0, :description => "Helemaal niet"
  option :a2, :value => 1, :description => "Niet"
  option :a3, :value => 2, :description => "Klein beetje"
  option :a4, :value => 3, :description => "Enigszins"
  option :a5, :value => 4, :description => "Redelijk"
  option :a6, :value => 5, :description => "Erg"
  option :a7, :value => 6, :description => "Heel erg"
end
end 

panel do
question :v_24, :type => :radio do
  title "24. In de afgelopen 28 dagen: is je figuur van invloed geweest op hoe je over jezelf dacht?"
  option :a1, :value => 0, :description => "Helemaal niet"
  option :a2, :value => 1, :description => "Niet"
  option :a3, :value => 2, :description => "Klein beetje"
  option :a4, :value => 3, :description => "Enigszins"
  option :a5, :value => 4, :description => "Redelijk"
  option :a6, :value => 5, :description => "Erg"
  option :a7, :value => 6, :description => "Heel erg"
end

question :v_25, :type => :radio do
  title "25. In de afgelopen 28 dagen: heb je je ontevreden gevoeld over je gewicht?"
  option :a1, :value => 0, :description => "Helemaal niet"
  option :a2, :value => 1, :description => "Niet"
  option :a3, :value => 2, :description => "Klein beetje"
  option :a4, :value => 3, :description => "Enigszins"
  option :a5, :value => 4, :description => "Redelijk"
  option :a6, :value => 5, :description => "Erg"
  option :a7, :value => 6, :description => "Heel erg"
end

question :v_26, :type => :radio do
  title "26. In de afgelopen 28 dagen: heb je je ontevreden gevoeld over je figuur?"
  option :a1, :value => 0, :description => "Helemaal niet"
  option :a2, :value => 1, :description => "Niet"
  option :a3, :value => 2, :description => "Klein beetje"
  option :a4, :value => 3, :description => "Enigszins"
  option :a5, :value => 4, :description => "Redelijk"
  option :a6, :value => 5, :description => "Erg"
  option :a7, :value => 6, :description => "Heel erg"
end
end

panel do
question :v_27, :type => :radio do
  title "27. In de afgelopen 28 dagen: heb je je zorgen gemaakt dat anderen je zouden zien eten?"
  option :a1, :value => 0, :description => "Helemaal niet"
  option :a2, :value => 1, :description => "Niet"
  option :a3, :value => 2, :description => "Klein beetje"
  option :a4, :value => 3, :description => "Enigszins"
  option :a5, :value => 4, :description => "Redelijk"
  option :a6, :value => 5, :description => "Erg"
  option :a7, :value => 6, :description => "Heel erg"
end

question :v_28, :type => :radio do
  title "28. In de afgelopen 28 dagen: heb je je rot gevoeld bij het zien van je eigen lichaam, zoals bijv. in een spiegel, in een etalageruit, tijdens het uitkleden of tijdens het nemen van een bad of douche?"
  option :a1, :value => 0, :description => "Helemaal niet"
  option :a2, :value => 1, :description => "Niet"
  option :a3, :value => 2, :description => "Klein beetje"
  option :a4, :value => 3, :description => "Enigszins"
  option :a5, :value => 4, :description => "Redelijk"
  option :a6, :value => 5, :description => "Erg"
  option :a7, :value => 6, :description => "Heel erg"
end

question :v_29, :type => :radio do
  title "29. In de afgelopen 28 dagen: heb je je ongemakkelijk gevoeld op momenten dat anderen je lichaam konden zien, zoals bijv. bij het omkleden in gemeenschappelijke omkleedruimtes, tijdens het zwemmen of bij het dragen van kleding waarin je figuur goed uitkomt?"
  option :a1, :value => 0, :description => "Helemaal niet"
  option :a2, :value => 1, :description => "Niet"
  option :a3, :value => 2, :description => "Klein beetje"
  option :a4, :value => 3, :description => "Enigszins"
  option :a5, :value => 4, :description => "Redelijk"
  option :a6, :value => 5, :description => "Erg"
  option :a7, :value => 6, :description => "Heel erg"
end
end

panel do
question :v_30, :type => :radio do
  title "30. Hoe vervelend zou je het vinden als je wordt gevraagd om jezelf in de komende maand wekelijks te wegen?"
    option :a1, :value => 0, :description => "Helemaal niet vervelend"
  option :a2, :value => 1, :description => "Niet vervelend"
  option :a3, :value => 2, :description => "Klein beetje vervelend"
  option :a4, :value => 3, :description => "Enigszins vervelend"
  option :a5, :value => 4, :description => "Redelijk vervelend"
  option :a6, :value => 5, :description => "Erg vervelend"
  option :a7, :value => 6, :description => "Heel erg vervelend"
end
end
end_panel

