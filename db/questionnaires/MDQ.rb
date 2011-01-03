# MDQ

# Project ID 676
# Date (GMT) 06-12-2010 20:52:41
# All values between 1 and 8 auto-recoded with -1
# Manual recodes: 15+1

key "mdq"
title "MDQ"
description ""

panel do
 title "MDQ - Mood Disorder Questionnaire"
 text "Deze vragenlijst richt zich op een periode of perioden in uw leven dat u niet in uw normale doen was. De vragenlijst bevat 15 vragen. 

Klik op 'Volgende vraag' om verder te gaan."
end

panel do
text "Heeft u ooit een periode meegemaakt, waarin u niet in uw normale doen was en....."
question :v_1, :type => :radio do
  title "1. ....u zich zo goed of zo super voelde dat anderen vonden dat u niet in uw normale doen was? Of waarin u zo druk was dat u problemen kreeg?"
  description ""
  option :a1, :value => 0, :description => "Nee"
  option :a2, :value => 1, :description => "Ja"
end
 text "

"
question :v_2, :type => :radio do
  title "2. ....u zo prikkelbaar was dat u mensen uitschold of begon te ruzi'en of te vechten?"
  description ""
  option :a1, :value => 0, :description => "Nee"
  option :a2, :value => 1, :description => "Ja"
end

question :v_3, :type => :radio do
  title "3. ....u zich aanzienlijk zelfbewuster voelde dan normaal?"
  description ""
  option :a1, :value => 0, :description => "Nee"
  option :a2, :value => 1, :description => "Ja"
end

question :v_4, :type => :radio do
  title "4. ....u veel minder sliep dan normaal en het gemis niet echt voelde?"
  description ""
  option :a1, :value => 0, :description => "Nee"
  option :a2, :value => 1, :description => "Ja"
end

question :v_5, :type => :radio do
  title "5. ....u behoorlijk spraakzamer was of sneller praatte dan normaal?"
  description ""
  option :a1, :value => 0, :description => "Nee"
  option :a2, :value => 1, :description => "Ja"
end

question :v_6, :type => :radio do
  title "6. ....de gedachten door uw hoofd raasden of u uw hoofd niet rustiger kon krijgen?"
  description ""
  option :a1, :value => 0, :description => "Nee"
  option :a2, :value => 1, :description => "Ja"
end
end
question :v_7, :type => :radio do
  title "7. ....u zo makkelijk afgeleid was door uw omgeving dat u moeite had met concentreren of bij de zaak te blijven?"
  description ""
  option :a1, :value => 0, :description => "Nee"
  option :a2, :value => 1, :description => "Ja"
end

question :v_8, :type => :radio do
  title "8. ....u aanzienlijk meer energie had dan normaal?"
  description ""
  option :a1, :value => 0, :description => "Nee"
  option :a2, :value => 1, :description => "Ja"
end

question :v_9, :type => :radio do
  title "9. ....u aanzienlijk actiever was of veel meer deed dan normaal?"
  description ""
  option :a1, :value => 0, :description => "Nee"
  option :a2, :value => 1, :description => "Ja"
end

question :v_10, :type => :radio do
  title "10. ....u aanzienlijk gezelliger was of meer uitging, bijv. meer vrienden opbelde midden in de nacht?"
  description ""
  option :a1, :value => 0, :description => "Nee"
  option :a2, :value => 1, :description => "Ja"
end

question :v_11, :type => :radio do
  title "11. ....u aanzienlijk meer ge'interesseerd was in seks dan gewoonlijk?"
  description ""
  option :a1, :value => 0, :description => "Nee"
  option :a2, :value => 1, :description => "Ja"
end

question :v_12, :type => :radio do
  title "12. ....u dingen deed die voor u ongebruikelijk zijn of die anderen misschien overdreven, belachelijk of onverstandig zouden vinden?"
  description ""
  option :a1, :value => 0, :description => "Nee"
  option :a2, :value => 1, :description => "Ja"
end

question :v_13, :type => :radio do
  title "13. ....u zo veel geld uitgaf dat u of uw gezin er problemen mee kreeg?"
  description ""
  option :a1, :value => 0, :description => "Nee"
  option :a2, :value => 1, :description => "Ja"
end

question :v_14, :type => :radio do
  title "14. Gebeurden deze dingen ooit in dezelfde periode?"
  description ""
  option :a1, :value => 0, :description => "Nee"
  option :a2, :value => 1, :description => "Ja"
end

question :v_15, :type => :radio do
  title "15. Hoeveel problemen kreeg u door deze dingen - bijv. op het werk, met de familie, met geld, met de wet, door ruzies of vechtpartijen?"
  description ""
  option :a1, :value => 1, :description => "Geen probleem"
  option :a2, :value => 2, :description => "Klein probleem"
  option :a3, :value => 3, :description => "Behoorlijk probleem"
  option :a4, :value => 4, :description => "Ernstig probleem"
end

end_panel

