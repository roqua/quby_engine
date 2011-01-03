# BSQ

# Project ID 724
# Date (GMT) 06-12-2010 20:43:43
# No values auto-recoded
# No manual recodes needed

key "BSQ"
title "Body Sensations Questionnaire"
description ""

panel do
 title "BSQ - Body Sensations Questionnaire"
 text "Hieronder staan lichamelijke gevoelens, die kunnen voorkomen, wanneer u gespannen of angstig bent. Geef aan hoe bang u bent voor deze gevoelens. De vragenlijst bestaat uit 17 lichamelijke gevoelens. Vink bij ieder gevoel het antwoord aan dat het beste aangeeft hoe bang u hiervoor bent:

1. *Niet* angstig of bezorg door dit gevoel;
2. *Een beetje* angstig door dit gevoel;
3. *Tamelijk* angstig door dit gevoel;
4. *Erg* angstig door dit gevoel;
5. *Heel erg* angstig door dit gevoel.



Klik op 'Volgende vraag' om verder te gaan."
end



panel do
question :v_1, :type => :radio do
  title "1. Hartkloppingen."
  description ""
  option :a1, :value => 1, :description => "Niet"
  option :a2, :value => 2, :description => "Een Beetje"
  option :a3, :value => 3, :description => "Tamelijk"
  option :a4, :value => 4, :description => "Erg"
  option :a5, :value => 5, :description => "Heel Erg"
end

question :v_2, :type => :radio do
  title "2. Druk of zwaar gevoel in je borst."
  description ""
  option :a1, :value => 1, :description => "Niet"
  option :a2, :value => 2, :description => "Een Beetje"
  option :a3, :value => 3, :description => "Tamelijk"
  option :a4, :value => 4, :description => "Erg"
  option :a5, :value => 5, :description => "Heel Erg"
end

question :v_3, :type => :radio do
  title "3. Verdoofd gevoel in je armen."
  description ""
  option :a1, :value => 1, :description => "Niet"
  option :a2, :value => 2, :description => "Een Beetje"
  option :a3, :value => 3, :description => "Tamelijk"
  option :a4, :value => 4, :description => "Erg"
  option :a5, :value => 5, :description => "Heel Erg"
end

question :v_4, :type => :radio do
  title "4. Tintelingen in je vingertoppen."
  description ""
  option :a1, :value => 1, :description => "Niet"
  option :a2, :value => 2, :description => "Een Beetje"
  option :a3, :value => 3, :description => "Tamelijk"
  option :a4, :value => 4, :description => "Erg"
  option :a5, :value => 5, :description => "Heel Erg"
end

question :v_5, :type => :radio do
  title "5. Verdoofd gevoel in een ander deel van je lichaam."
  description ""
  option :a1, :value => 1, :description => "Niet"
  option :a2, :value => 2, :description => "Een Beetje"
  option :a3, :value => 3, :description => "Tamelijk"
  option :a4, :value => 4, :description => "Erg"
  option :a5, :value => 5, :description => "Heel Erg"
end
end

panel do
question :v_6, :type => :radio do
  title "6. Gevoel van kortademigheid."
  description ""
  option :a1, :value => 1, :description => "Niet"
  option :a2, :value => 2, :description => "Een Beetje"
  option :a3, :value => 3, :description => "Tamelijk"
  option :a4, :value => 4, :description => "Erg"
  option :a5, :value => 5, :description => "Heel Erg"
end

question :v_7, :type => :radio do
  title "7. Duizeligheid."
  description ""
  option :a1, :value => 1, :description => "Niet"
  option :a2, :value => 2, :description => "Een Beetje"
  option :a3, :value => 3, :description => "Tamelijk"
  option :a4, :value => 4, :description => "Erg"
  option :a5, :value => 5, :description => "Heel Erg"
end

question :v_8, :type => :radio do
  title "8. Wazig of gestoord zien."
  description ""
  option :a1, :value => 1, :description => "Niet"
  option :a2, :value => 2, :description => "Een Beetje"
  option :a3, :value => 3, :description => "Tamelijk"
  option :a4, :value => 4, :description => "Erg"
  option :a5, :value => 5, :description => "Heel Erg"
end

question :v_9, :type => :radio do
  title "9. Misselijkheid."
  description ""
  option :a1, :value => 1, :description => "Niet"
  option :a2, :value => 2, :description => "Een Beetje"
  option :a3, :value => 3, :description => "Tamelijk"
  option :a4, :value => 4, :description => "Erg"
  option :a5, :value => 5, :description => "Heel Erg"
end

question :v_10, :type => :radio do
  title "10. Vlinders in je buik hebben."
  description ""
  option :a1, :value => 1, :description => "Niet"
  option :a2, :value => 2, :description => "Een Beetje"
  option :a3, :value => 3, :description => "Tamelijk"
  option :a4, :value => 4, :description => "Erg"
  option :a5, :value => 5, :description => "Heel Erg"
end
end

panel do

question :v_11, :type => :radio do
  title "11. Een zwaar gevoel in je maag hebben."
  description ""
  option :a1, :value => 1, :description => "Niet"
  option :a2, :value => 2, :description => "Een Beetje"
  option :a3, :value => 3, :description => "Tamelijk"
  option :a4, :value => 4, :description => "Erg"
  option :a5, :value => 5, :description => "Heel Erg"
end

question :v_12, :type => :radio do
  title "12. Een prop in je keel hebben."
  description ""
  option :a1, :value => 1, :description => "Niet"
  option :a2, :value => 2, :description => "Een Beetje"
  option :a3, :value => 3, :description => "Tamelijk"
  option :a4, :value => 4, :description => "Erg"
  option :a5, :value => 5, :description => "Heel Erg"
end

question :v_13, :type => :radio do
  title "13. Slappe benen hebben."
  description ""
  option :a1, :value => 1, :description => "Niet"
  option :a2, :value => 2, :description => "Een Beetje"
  option :a3, :value => 3, :description => "Tamelijk"
  option :a4, :value => 4, :description => "Erg"
  option :a5, :value => 5, :description => "Heel Erg"
end

question :v_14, :type => :radio do
  title "14. Zweten."
  description ""
  option :a1, :value => 1, :description => "Niet"
  option :a2, :value => 2, :description => "Een Beetje"
  option :a3, :value => 3, :description => "Tamelijk"
  option :a4, :value => 4, :description => "Erg"
  option :a5, :value => 5, :description => "Heel Erg"
end

question :v_15, :type => :radio do
  title "15. Een droge keel hebben."
  description ""
  option :a1, :value => 1, :description => "Niet"
  option :a2, :value => 2, :description => "Een Beetje"
  option :a3, :value => 3, :description => "Tamelijk"
  option :a4, :value => 4, :description => "Erg"
  option :a5, :value => 5, :description => "Heel Erg"
end
end

panel do
question :v_16, :type => :radio do
  title "16. Je verward voelen en niet meer weten waar je bent."
  description ""
  option :a1, :value => 1, :description => "Niet"
  option :a2, :value => 2, :description => "Een Beetje"
  option :a3, :value => 3, :description => "Tamelijk"
  option :a4, :value => 4, :description => "Erg"
  option :a5, :value => 5, :description => "Heel Erg"
end

question :v_17, :type => :radio do
  title "17. Gevoel los te zijn van je lichaam, maar gedeeltelijk aanwezig te zijn."
  description ""
  option :a1, :value => 1, :description => "Niet"
  option :a2, :value => 2, :description => "Een Beetje"
  option :a3, :value => 3, :description => "Tamelijk"
  option :a4, :value => 4, :description => "Erg"
  option :a5, :value => 5, :description => "Heel Erg"
end
end
end_panel

