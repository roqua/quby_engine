# OQ-45

# Project ID 92421
# Date (GMT) 15-01-2010 09:08:41

key "oq-45"
title "OQ-45"
description ""
panel do
  title "Outcome Questionnaire (OQ®-45.2)"
text " Help ons begrijpen hoe u zich de afgelopen week, tot en met vandaag, hebt gevoeld. Lees elke vraag goed door en klik het antwoord aan die uw huidige situatie het best beschrijft. In deze vragenlijst wordt 'werk' gedefinieerd als baan, school, huishoudelijk werk, vrijwilligerswerk enz. 


Deze vragenlijst bevat 45 vragen.

Klik op 'Volgende vraag' om verder te gaan."
end


question :v_1, :type => :radio, :required => true do
  title "1. Ik kan goed met anderen overweg."
  description ""
  option :a5, :value => 5, :description => "Nooit"
  option :a4, :value => 4, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a2, :value => 2, :description => "Regelmatig"
  option :a1, :value => 1, :description => "Bijna altijd"
end

question :v_2, :type => :radio, :required => true do
  title "2. Ik word gauw moe."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

question :v_3, :type => :radio, :required => true do
  title "3. Ik ben nergens in geïnteresseerd."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

question :v_4, :type => :radio, :required => true do
  title "4. Ik sta onder stress op het werk/op school."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

question :v_5, :type => :radio, :required => true do
  title "5. Ik geef mezelf overal de schuld van."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

question :v_6, :type => :radio, :required => true do
  title "6. Ik ben geïrriteerd."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

question :v_7, :type => :radio, :required => true do
  title "7. Ik ben ongelukkig in mijn huwelijk/relatie."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

question :v_8, :type => :radio, :required => true do
  title "8. Ik denk erover om een einde aan mijn leven te maken."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

question :v_9, :type => :radio, :required => true do
  title "9. Ik voel me zwak."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

question :v_10, :type => :radio, :required => true do
  title "10. Ik ben angstig."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

question :v_11, :type => :radio, :required => true do
  title "11. Na zwaar gedronken te hebben, moet ik de volgende morgen weer drinken om op gang te komen."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

question :v_12, :type => :radio, :required => true do
  title "12. Ik vind bevrediging in mijn werk/school."
  description ""
  option :a1, :value => 1, :description => "Bijna altijd"
  option :a2, :value => 2, :description => "Regelmatig"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Zelden"
  option :a5, :value => 5, :description => "Nooit"
end

question :v_13, :type => :radio, :required => true do
  title "13. Ik ben een tevreden mens."
  description ""
  option :a1, :value => 1, :description => "Bijna altijd"
  option :a2, :value => 2, :description => "Regelmatig"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Zelden"
  option :a5, :value => 5, :description => "Nooit"
end

question :v_14, :type => :radio, :required => true do
  title "14. Ik werk/studeer te veel."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

question :v_15, :type => :radio, :required => true do
  title "15. Ik heb het gevoel dat ik waardeloos ben."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

question :v_16, :type => :radio, :required => true do
  title "16. Ik maak me zorgen over problemen in mijn familie."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

question :v_18, :type => :radio, :required => true do
  title "17. Ik heb een onbevredigend seksleven."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

question :v_19, :type => :radio, :required => true do
  title "18. Ik voel me eenzaam."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

question :v_20, :type => :radio, :required => true do
  title "19. Ik heb vaak ruzie."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

question :v_21, :type => :radio, :required => true do
  title "20. Ik voel me bemind en welkom."
  description ""
  option :a1, :value => 1, :description => "Bijna altijd"
  option :a2, :value => 2, :description => "Regelmatig"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Zelden"
  option :a5, :value => 5, :description => "Nooit"
end

question :v_22, :type => :radio, :required => true do
  title "21. Ik geniet van mijn vrije tijd."
  description ""
  option :a1, :value => 1, :description => "Bijna altijd"
  option :a2, :value => 2, :description => "Regelmatig"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Zelden"
  option :a5, :value => 5, :description => "Nooit"
end

question :v_23, :type => :radio, :required => true do
  title "22. Ik vind het moeilijk om me te concentreren."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

question :v_24, :type => :radio, :required => true do
  title "23. Ik voel me hopeloos over de toekomst."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

question :v_25, :type => :radio, :required => true do
  title "24. Ik waardeer mezelf."
  description ""
  option :a1, :value => 1, :description => "Bijna altijd"
  option :a2, :value => 2, :description => "Regelmatig"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Zelden"
  option :a5, :value => 5, :description => "Nooit"
end

question :v_26, :type => :radio, :required => true do
  title "25. Er komen verontrustende gedachten in mij op die ik niet kwijt kan raken."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

question :v_27, :type => :radio, :required => true do
  title "26. Ik erger me aan mensen die kritiek hebben op mijn drinken (of drugsgebruik)."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

question :v_28, :type => :radio, :required => true do
  title "27. Ik heb last van mijn maag."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

question :v_29, :type => :radio, :required => true do
  title "28. Ik werk/studeer niet zo goed als vroeger."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

question :v_30, :type => :radio, :required => true do
  title "29. Mijn hart bonst te veel."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

question :v_31, :type => :radio, :required => true do
  title "30. Ik vind het moeilijk om met vrienden en goede kennissen om te gaan."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

question :v_32, :type => :radio, :required => true do
  title "31. Ik ben tevreden met mijn leven."
  description ""
  option :a1, :value => 1, :description => "Bijna altijd"
  option :a2, :value => 2, :description => "Regelmatig"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Zelden"
  option :a5, :value => 5, :description => "Nooit"
end

question :v_33, :type => :radio, :required => true do
  title "32. Ik heb moeilijkheden op het werk/op school door mijn drinken of drugsgebruik."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

question :v_34, :type => :radio, :required => true do
  title "33. Ik heb het gevoel dat er iets ergs gaat gebeuren."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

question :v_35, :type => :radio, :required => true do
  title "34. Ik heb spierpijn."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

question :v_36, :type => :radio, :required => true do
  title "35. Ik ben bang voor open ruimten, autorijden, of in de bus, trein enz. rijden."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

question :v_37, :type => :radio, :required => true do
  title "36. Ik ben nerveus."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

question :v_38, :type => :radio, :required => true do
  title "37. Ik vind dat de relatie met mijn naasten (bijv. ouders, partner, kinderen, vrienden) goed is."
  description ""
  option :a1, :value => 1, :description => "Bijna altijd"
  option :a2, :value => 2, :description => "Regelmatig"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Zelden"
  option :a5, :value => 5, :description => "Nooit"
end

question :v_39, :type => :radio, :required => true do
  title "38. Ik heb het gevoel dat het niet goed gaat met mijn werk/schoolwerk."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

question :v_40, :type => :radio, :required => true do
  title "39. Ik heb te veel meningsverschillen op het werk/op school."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

question :v_41, :type => :radio, :required => true do
  title "40. Ik heb het gevoel dat er iets mis is met mijn verstand/geest."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

question :v_42, :type => :radio, :required => true do
  title "41. Ik kan moeilijk in slaap vallen of doorslapen."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

question :v_43, :type => :radio, :required => true do
  title "42. Ik voel me neerslachtig."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

question :v_44, :type => :radio, :required => true do
  title "43. Ik ben tevreden met mijn relaties met anderen."
  description ""
  option :a1, :value => 1, :description => "Bijna altijd"
  option :a2, :value => 2, :description => "Regelmatig"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Zelden"
  option :a5, :value => 5, :description => "Nooit"
end

question :v_45, :type => :radio, :required => true do
  title "44. Ik ben zo kwaad op het werk/op school dat ik iets kan doen, waarvan ik spijt zou kunnen krijgen."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

question :v_46, :type => :radio, :required => true do
  title "45. Ik lijd aan hoofdpijn."
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Regelmatig"
  option :a5, :value => 5, :description => "Bijna altijd"
end

