# ADHD Kindertijd vragenlijst over aandachtsproblemen en hyperactiviteit

# Project ID 574
# Date (GMT) 06-12-2010 20:42:41
# All values between 1 and 8 auto-recoded with -1
# No manual recodes needed

key "adhd_kindertijd"
title "Vragenlijst_over_aandachtsproblemen_en_hyperactiviteit (ADHD kindertijd)"
description ""

panel do
 title "ADHD vragenlijst over aandachtsproblemen en hyperactiviteit - Kindertijd"
 text "De bedoeling van deze vragenlijst is om meer inzicht te krijgen in problemen die u mogelijk in uw kindertijd heeft ervaren op het gebied van aandacht en hyperactiviteit. Kruis bij elke vraag het antwoord aan dat het beste uw gedrag *als kind (0-12 jaar)* beschrijft.

Deze vragenlijst bevat 23 vragen.

Klik op 'Volgende vraag' om verder te gaan."
end

panel do
question :v_1, :type => :radio, :required => true do
  title "1. Ik lette onvoldoende op details bij schoolwerk."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end

question :v_2, :type => :radio, :required => true do
  title "2. Ik friemelde met handen of voeten."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end

question :v_3, :type => :radio, :required => true do
  title "3. Ik maakte slordige fouten in schoolwerk."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end
question :v_4, :type => :radio, :required => true do
  title "4. Ik zat te wiebelen en te draaien op de stoel."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end

question :v_5, :type => :radio, :required => true do
  title "5. Ik kon de aandacht slecht bij bezigheden houden."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end
end

panel do
question :v_6, :type => :radio, :required => true do
  title "6. Ik stond snel op van m'n stoel in situaties waarin verwacht werd dat ik netjes bleef zitten."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end

question :v_7, :type => :radio, :required => true do
  title "7. Ik luisterde slecht wanneer anderen iets zeiden."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end

question :v_8, :type => :radio, :required => true do
  title "8. Ik voelde me rusteloos."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end
question :v_9, :type => :radio, :required => true do
  title "9. Ik verveelde me snel."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end

question :v_10, :type => :radio, :required => true do
  title "10. Ik had moeite aanwijzingen op te volgen."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end
end

panel do
question :v_11, :type => :radio, :required => true do
  title "11. Ik begon aan karweitjes of werk, maar maakte ze niet af."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end

question :v_12, :type => :radio, :required => true do
  title "12. Ik kon me moeilijk ontspannen."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end

question :v_13, :type => :radio, :required => true do
  title "13. Ik had moeite rustig te spelen."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end
question :v_14, :type => :radio, :required => true do
  title "14. Ik kon bezigheden of taken moeilijk organiseren."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end

question :v_15, :type => :radio, :required => true do
  title "15. Ik was voortdurend 'in de weer', als 'door een motor aangedreven'."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end
end

panel do
question :v_16, :type => :radio, :required => true do
  title "16. Ik probeerde onder bezigheden uit te komen waarop ik me langere tijd moest concentreren."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end

question :v_17, :type => :radio, :required => true do
  title "17. Ik praatte aan 'e'en stuk door."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end

question :v_18, :type => :radio, :required => true do
  title "18. Ik raakte dingen kwijt die nodig zijn voor taken of bezigheden."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end
question :v_19, :type => :radio, :required => true do
  title "19. Ik gaf antwoord voordat vragen waren afgemaakt."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end

question :v_20, :type => :radio, :required => true do
  title "20. Ik was snel afgeleid."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end
end

panel do
question :v_21, :type => :radio, :required => true do
  title "21. Ik vond het moeilijk op mijn beurt te wachten."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end

question :v_22, :type => :radio, :required => true do
  title "22. Ik was vergeetachtig bij alledaagse bezigheden."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end

question :v_23, :type => :radio, :required => true do
  title "23. Ik onderbrak anderen of viel ze in de rede."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end
end
end_panel

