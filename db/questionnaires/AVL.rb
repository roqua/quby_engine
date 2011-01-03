title "AVL"

key "Agressie Vragenlijst (AVL)"
title "Agressie Vragenlijst (AVL)"
description " "

panel do
    title "Agressie Vragenlijst (AVL)"
    text "*Instructie.* U krijgt een lijst bestaande uit 29 uitspraken. Wilt u bij elke uitspraak aangeven in hoeverre deze uitspraak op u van toepassing is?

Klik op 'Volgende vraag' om verder te gaan."
end

panel do
question :q01, :type => :radio, :required => true do
  title "1. Ik heb wel eens iemand die ik ken bedreigd"
  option :q03a01, :value => 1, :description => "helemaal mee oneens"
  option :q03a02, :value => 2, :description => "tamelijk mee oneens"
  option :q03a03, :value => 3, :description => "weet niet"
  option :q03a04, :value => 4, :description => "tamelijk mee eens"
  option :q03a05, :value => 5, :description => "helemaal mee eens"
end
question :q02, :type => :radio, :required => true do
  title "2. Ik voel me soms net een kruitvat dat op ontploffen staat"
  option :q03a01, :value => 1, :description => "helemaal mee oneens"
  option :q03a02, :value => 2, :description => "tamelijk mee oneens"
  option :q03a03, :value => 3, :description => "weet niet"
  option :q03a04, :value => 4, :description => "tamelijk mee eens"
  option :q03a05, :value => 5, :description => "helemaal mee eens"
end
question :q03, :type => :radio, :required => true do
  title "3. Als iemand mij slaat sla ik terug"
  option :q03a01, :value => 1, :description => "helemaal mee oneens"
  option :q03a02, :value => 2, :description => "tamelijk mee oneens"
  option :q03a03, :value => 3, :description => "weet niet"
  option :q03a04, :value => 4, :description => "tamelijk mee eens"
  option :q03a05, :value => 5, :description => "helemaal mee eens"
end
question :q04, :type => :radio, :required => true do
  title "4. Mijn vrienden vinden me nogal ruzieachtig"
  option :q03a01, :value => 1, :description => "helemaal mee oneens"
  option :q03a02, :value => 2, :description => "tamelijk mee oneens"
  option :q03a03, :value => 3, :description => "weet niet"
  option :q03a04, :value => 4, :description => "tamelijk mee eens"
  option :q03a05, :value => 5, :description => "helemaal mee eens"
end
end

panel do
question :q05, :type => :radio, :required => true do
  title "5. Als ik flink getreiterd wordt kan het gebeuren dat ik iemand sla"
  option :q03a01, :value => 1, :description => "helemaal mee oneens"
  option :q03a02, :value => 2, :description => "tamelijk mee oneens"
  option :q03a03, :value => 3, :description => "weet niet"
  option :q03a04, :value => 4, :description => "tamelijk mee eens"
  option :q03a05, :value => 5, :description => "helemaal mee eens"
end

question :q06, :type => :radio, :required => true do
  title "6. Ik wantrouw onbekenden die overdreven vriendelijk tegen me doen"
  option :q03a01, :value => 1, :description => "helemaal mee oneens"
  option :q03a02, :value => 2, :description => "tamelijk mee oneens"
  option :q03a03, :value => 3, :description => "weet niet"
  option :q03a04, :value => 4, :description => "tamelijk mee eens"
  option :q03a05, :value => 5, :description => "helemaal mee eens"
end
question :q07, :type => :radio, :required => true do
  title "7. Ik heb soms het gevoel dat men me achter mijn rug om uitlacht"
  option :q03a01, :value => 1, :description => "helemaal mee oneens"
  option :q03a02, :value => 2, :description => "tamelijk mee oneens"
  option :q03a03, :value => 3, :description => "weet niet"
  option :q03a04, :value => 4, :description => "tamelijk mee eens"
  option :q03a05, :value => 5, :description => "helemaal mee eens"
end
question :q08, :type => :radio, :required => true do
  title "8. Het kost me moeite mijn kalmte te bewaren"
  option :q03a01, :value => 1, :description => "helemaal mee oneens"
  option :q03a02, :value => 2, :description => "tamelijk mee oneens"
  option :q03a03, :value => 3, :description => "weet niet"
  option :q03a04, :value => 4, :description => "tamelijk mee eens"
  option :q03a05, :value => 5, :description => "helemaal mee eens"
end
end

panel do
question :q09, :type => :radio, :required => true do
  title "9. Zo nu en dan kan ik de neiging iemand te slaan niet onderdrukken"
  option :q03a01, :value => 1, :description => "helemaal mee oneens"
  option :q03a02, :value => 2, :description => "tamelijk mee oneens"
  option :q03a03, :value => 3, :description => "weet niet"
  option :q03a04, :value => 4, :description => "tamelijk mee eens"
  option :q03a05, :value => 5, :description => "helemaal mee eens"
end
question :q10, :type => :radio, :required => true do
  title "10. Ik ben gelijkmatig van humeur"
  option :q03a01, :value => 1, :description => "helemaal mee oneens"
  option :q03a02, :value => 2, :description => "tamelijk mee oneens"
  option :q03a03, :value => 3, :description => "weet niet"
  option :q03a04, :value => 4, :description => "tamelijk mee eens"
  option :q03a05, :value => 5, :description => "helemaal mee eens"
end
question :q11, :type => :radio, :required => true do
  title "11. Sommige vrienden vinden me een driftkop"
  option :q03a01, :value => 1, :description => "helemaal mee oneens"
  option :q03a02, :value => 2, :description => "tamelijk mee oneens"
  option :q03a03, :value => 3, :description => "weet niet"
  option :q03a04, :value => 4, :description => "tamelijk mee eens"
  option :q03a05, :value => 5, :description => "helemaal mee eens"
end
question :q12, :type => :radio, :required => true do
  title "12. Ik verga soms van jaloersheid"
  option :q03a01, :value => 1, :description => "helemaal mee oneens"
  option :q03a02, :value => 2, :description => "tamelijk mee oneens"
  option :q03a03, :value => 3, :description => "weet niet"
  option :q03a04, :value => 4, :description => "tamelijk mee eens"
  option :q03a05, :value => 5, :description => "helemaal mee eens"
end
end

panel do
question :q13, :type => :radio, :required => true do
  title "13. Ik kan geen goede reden bedenken waarom ik ooit iemand zou 
      slaan"
  option :q03a01, :value => 1, :description => "helemaal mee oneens"
  option :q03a02, :value => 2, :description => "tamelijk mee oneens"
  option :q03a03, :value => 3, :description => "weet niet"
  option :q03a04, :value => 4, :description => "tamelijk mee eens"
  option :q03a05, :value => 5, :description => "helemaal mee eens"
end
question :q14, :type => :radio, :required => true do
  title "14. Ik raak iets vaker dan gemiddeld bij vechtpartijtjes betrokken"
  option :q03a01, :value => 1, :description => "helemaal mee oneens"
  option :q03a02, :value => 2, :description => "tamelijk mee oneens"
  option :q03a03, :value => 3, :description => "weet niet"
  option :q03a04, :value => 4, :description => "tamelijk mee eens"
  option :q03a05, :value => 5, :description => "helemaal mee eens"
end
question :q15, :type => :radio, :required => true do
  title "15. Ik word snel kwaad, maar ben ook snel weer afgekoeld"
  option :q03a01, :value => 1, :description => "helemaal mee oneens"
  option :q03a02, :value => 2, :description => "tamelijk mee oneens"
  option :q03a03, :value => 3, :description => "weet niet"
  option :q03a04, :value => 4, :description => "tamelijk mee eens"
  option :q03a05, :value => 5, :description => "helemaal mee eens"
end
question :q16, :type => :radio, :required => true do
  title "16. Soms schiet ik uit mijn slof zonder dat daar een aanleiding voor is"
  option :q03a01, :value => 1, :description => "helemaal mee oneens"
  option :q03a02, :value => 2, :description => "tamelijk mee oneens"
  option :q03a03, :value => 3, :description => "weet niet"
  option :q03a04, :value => 4, :description => "tamelijk mee eens"
  option :q03a05, :value => 5, :description => "helemaal mee eens"
end
end

panel do
question :q17, :type => :radio, :required => true do
  title "17. Het lijkt alsof anderen altijd meer geluk hebben"
  option :q03a01, :value => 1, :description => "helemaal mee oneens"
  option :q03a02, :value => 2, :description => "tamelijk mee oneens"
  option :q03a03, :value => 3, :description => "weet niet"
  option :q03a04, :value => 4, :description => "tamelijk mee eens"
  option :q03a05, :value => 5, :description => "helemaal mee eens"
end
question :q18, :type => :radio, :required => true do
  title "18. Ik ben wel eens door iemand zo opgejut dat we slaags raakten"
  option :q03a01, :value => 1, :description => "helemaal mee oneens"
  option :q03a02, :value => 2, :description => "tamelijk mee oneens"
  option :q03a03, :value => 3, :description => "weet niet"
  option :q03a04, :value => 4, :description => "tamelijk mee eens"
  option :q03a05, :value => 5, :description => "helemaal mee eens"
end
question :q19, :type => :radio, :required => true do
  title "19. Als ik geweld moet gebruiken om voor mijn rechten op te komen,dan doe ik dat"
  option :q03a01, :value => 1, :description => "helemaal mee oneens"
  option :q03a02, :value => 2, :description => "tamelijk mee oneens"
  option :q03a03, :value => 3, :description => "weet niet"
  option :q03a04, :value => 4, :description => "tamelijk mee eens"
  option :q03a05, :value => 5, :description => "helemaal mee eens"
end
question :q20, :type => :radio, :required => true do
  title "20. Ik ben wel eens zo kwaad geworden dat ik dingen stuk gemaakt heb"
  option :q03a01, :value => 1, :description => "helemaal mee oneens"
  option :q03a02, :value => 2, :description => "tamelijk mee oneens"
  option :q03a03, :value => 3, :description => "weet niet"
  option :q03a04, :value => 4, :description => "tamelijk mee eens"
  option :q03a05, :value => 5, :description => "helemaal mee eens"
end
end

panel do
question :q21, :type => :radio, :required => true do
  title "21. Ik weet dat “vrienden” achter mijn rug om over me praten"
  option :q03a01, :value => 1, :description => "helemaal mee oneens"
  option :q03a02, :value => 2, :description => "tamelijk mee oneens"
  option :q03a03, :value => 3, :description => "weet niet"
  option :q03a04, :value => 4, :description => "tamelijk mee eens"
  option :q03a05, :value => 5, :description => "helemaal mee eens"
end
question :q22, :type => :radio, :required => true do
  title "22. Als mensen me ergeren, zeg ik soms wel wat ik van ze vind"
  option :q03a01, :value => 1, :description => "helemaal mee oneens"
  option :q03a02, :value => 2, :description => "tamelijk mee oneens"
  option :q03a03, :value => 3, :description => "weet niet"
  option :q03a04, :value => 4, :description => "tamelijk mee eens"
  option :q03a05, :value => 5, :description => "helemaal mee eens"
end
question :q23, :type => :radio, :required => true do
  title "23. Ik zeg het mijn vrienden ronduit als ik het niet met ze eens ben"
  option :q03a01, :value => 1, :description => "helemaal mee oneens"
  option :q03a02, :value => 2, :description => "tamelijk mee oneens"
  option :q03a03, :value => 3, :description => "weet niet"
  option :q03a04, :value => 4, :description => "tamelijk mee eens"
  option :q03a05, :value => 5, :description => "helemaal mee eens"
end
question :q24, :type => :radio, :required => true do
  title "24. Als iemand bijzonder aardig doet, vraag ik me af wat hij van me wil"
  option :q03a01, :value => 1, :description => "helemaal mee oneens"
  option :q03a02, :value => 2, :description => "tamelijk mee oneens"
  option :q03a03, :value => 3, :description => "weet niet"
  option :q03a04, :value => 4, :description => "tamelijk mee eens"
  option :q03a05, :value => 5, :description => "helemaal mee eens"
end
end

panel do
question :q25, :type => :radio, :required => true do
  title "25. Ik krijg altijd ruzie als mensen het niet met me eens zijn"
  option :q03a01, :value => 1, :description => "helemaal mee oneens"
  option :q03a02, :value => 2, :description => "tamelijk mee oneens"
  option :q03a03, :value => 3, :description => "weet niet"
  option :q03a04, :value => 4, :description => "tamelijk mee eens"
  option :q03a05, :value => 5, :description => "helemaal mee eens"
end
question :q26, :type => :radio, :required => true do
  title "26. Als ik gedwarsboomd word, laat ik mijn ergernis merken"
  option :q03a01, :value => 1, :description => "helemaal mee oneens"
  option :q03a02, :value => 2, :description => "tamelijk mee oneens"
  option :q03a03, :value => 3, :description => "weet niet"
  option :q03a04, :value => 4, :description => "tamelijk mee eens"
  option :q03a05, :value => 5, :description => "helemaal mee eens"
end
question :q27, :type => :radio, :required => true do
  title "27. Ik merk dat ik het vaak niet met anderen eens ben"
  option :q03a01, :value => 1, :description => "helemaal mee oneens"
  option :q03a02, :value => 2, :description => "tamelijk mee oneens"
  option :q03a03, :value => 3, :description => "weet niet"
  option :q03a04, :value => 4, :description => "tamelijk mee eens"
  option :q03a05, :value => 5, :description => "helemaal mee eens"
end
question :q28, :type => :radio, :required => true do
  title "28. Soms heb ik het gevoel dat het leven me oneerlijk bedeeld heeft"
  option :q03a01, :value => 1, :description => "helemaal mee oneens"
  option :q03a02, :value => 2, :description => "tamelijk mee oneens"
  option :q03a03, :value => 3, :description => "weet niet"
  option :q03a04, :value => 4, :description => "tamelijk mee eens"
  option :q03a05, :value => 5, :description => "helemaal mee eens"
end
question :q29, :type => :radio, :required => true do
  title "29. Ik vraag me af waarom ik me soms zo verbitterd voel"
  option :q03a01, :value => 1, :description => "helemaal mee oneens"
  option :q03a02, :value => 2, :description => "tamelijk mee oneens"
  option :q03a03, :value => 3, :description => "weet niet"
  option :q03a04, :value => 4, :description => "tamelijk mee eens"
  option :q03a05, :value => 5, :description => "helemaal mee eens"
end
end
end_panel
