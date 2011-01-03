# ADHD vragenlijst over aandachtsproblemen en hyperactiviteit

# Project ID 504
# Date (GMT) 06-12-2010 20:42:57
# All values between 1 and 8 auto-recoded with -1
# No manual recodes needed

key "adhd"
title "Vragenlijst over aandachtsproblemen en hyperactiviteit (ADHD)"
description ""

panel do
 title "ADHD vragenlijst over aandachtsproblemen en hyperactiviteit"
 text "De bedoeling van deze vragenlijst is om meer inzicht te krijgen in problemen die u mogelijk ervaart op het gebied van aandacht en hyperactiviteit. De vragenlijst omvat 23 vragen. 

Kruis bij elke vraag het antwoord aan dat het beste uw gedrag van de *afgelopen zes maanden* beschrijft.

Klik op 'Volgende vraag' om verder te gaan."
end

panel do
question :v_1, :type => :radio, :required => true do
  title "1. Ik let onvoldoende op details bij mijn werk."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end

question :v_2, :type => :radio, :required => true do
  title "2. Wanneer ik zit, friemel ik met mijn handen of voeten."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end

question :v_3, :type => :radio, :required => true do
  title "3. Ik maak slordige fouten in mijn werk."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end

question :v_4, :type => :radio, :required => true do
  title "4. Ik zit te wiebelen en te draaien in mijn stoel."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end

question :v_5, :type => :radio, :required => true do
  title "5. Wanneer ik met iets bezig ben, kan ik er met mijn aandacht slecht bij blijven."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end
end

panel do
question :v_6, :type => :radio, :required => true do
  title "6. Ik sta snel op van mijn stoel in situaties waarin verwacht wordt dat ik netjes blijf zitten."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end

question :v_7, :type => :radio, :required => true do
  title "7. Ik luister slecht wanneer anderen iets tegen mij zeggen."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end

question :v_8, :type => :radio, :required => true do
  title "8. Ik voel me rusteloos."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end
question :v_9, :type => :radio, :required => true do
  title "9. Ik verveel me snel."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end

question :v_10, :type => :radio, :required => true do
  title "10. Ik heb moeite aanwijzingen op te volgen."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end
end

panel do
question :v_11, :type => :radio, :required => true do
  title "11. Karweitjes of werk waar ik aan begin, maak ik niet af."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end

question :v_12, :type => :radio, :required => true do
  title "12. Ik kan me moeilijk ontspannen in mijn vrije tijd."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end

question :v_13, :type => :radio, :required => true do
  title "13. In mijn vakantie of vrije tijd zoek ik een omgeving met drukte en lawaai."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end
question :v_14, :type => :radio, :required => true do
  title "14. Ik kan mijn bezigheden of taken moeilijk organiseren."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end

question :v_15, :type => :radio, :required => true do
  title "15. Ik ben voortdurend 'in de weer', alsof ik 'door een motor word aangedreven'."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end
end

panel do
question :v_16, :type => :radio, :required => true do
  title "16. Ik probeer onder bezigheden uit te komen waarop ik me langere tijd moet concentreren."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end

question :v_17, :type => :radio, :required => true do
  title "17. Ik praat aan 'e'en stuk door."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end

question :v_18, :type => :radio, :required => true do
  title "18. Ik raak dingen kwijt die ik nodig heb voor taken of bezigheden."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end
question :v_19, :type => :radio, :required => true do
  title "19. Ik geef antwoord voordat vragen zijn afgemaakt."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end

question :v_20, :type => :radio, :required => true do
  title "20. Ik ben snel afgeleid."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end
end

panel do
question :v_21, :type => :radio, :required => true do
  title "21. Ik vind het moeilijk op mijn beurt te wachten."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end
question :v_22, :type => :radio, :required => true do
  title "22. Ik ben vergeetachtig bij alledaagse bezigheden."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end

question :v_23, :type => :radio, :required => true do
  title "23. Ik onderbreek anderen of val ze in de rede."
  description ""
  option :a1, :value => 0, :description => "Nooit of zelden"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Vaak"
  option :a4, :value => 3, :description => "Erg vaak"
end
end
end_panel

