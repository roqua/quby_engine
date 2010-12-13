# CSQ

# Project ID 456
# Date (GMT) 06-12-2010 20:44:01
# No values auto-recoded
# No manual recodes needed

key "csq"
title "CSQ"
description ""

start_panel

question :v_1, :type => :radio do
  title "1. Hoe beoordeelt u de kwaliteit van de door u ontvangen zorg?"
  description ""
  option :a1, :value => 1, :description => "Slecht"
  option :a2, :value => 2, :description => "Redelijk"
  option :a3, :value => 3, :description => "Goed"
  option :a4, :value => 4, :description => "Uitstekend"
end

question :v_2, :type => :radio do
  title "2. Kreeg u het soort zorg dat u wilde?"
  description ""
  option :a1, :value => 1, :description => "Nee, beslist niet"
  option :a2, :value => 2, :description => "Nee, niet echt"
  option :a3, :value => 3, :description => "Ja, in het algemeen wel"
  option :a4, :value => 4, :description => "Ja, zeker"
end

question :v_3, :type => :radio do
  title "3. In hoeverre kwam ons aanbod tegemoet aan uw behoeften aan zorg?"
  description ""
  option :a1, :value => 1, :description => "Geen van mijn zorgbehoeften zijn vervuld"
  option :a2, :value => 2, :description => "Slechts enkele van mijn zorgbehoeften zijn vervuld"
  option :a3, :value => 3, :description => "De meeste van mijn zorgbehoeften zijn vervuld"
  option :a4, :value => 4, :description => "Bijna al mijn zorgbehoeften zijn vervuld"
end

question :v_4, :type => :radio do
  title "4. Als een vriend vergelijkbare hulp nodig had, zou u onze hulpverlening dan aanraden?"
  description ""
  option :a1, :value => 1, :description => "Nee, beslist niet"
  option :a2, :value => 2, :description => "Nee, dat denk ik niet"
  option :a3, :value => 3, :description => "Ja, dat denk ik wel"
  option :a4, :value => 4, :description => "Ja, zeker"
end

question :v_5, :type => :radio do
  title "5. Hoe tevreden bent u met de hoeveelheid hulp die u heeft gekregen?"
  description ""
  option :a1, :value => 1, :description => "Behoorlijk ontevreden"
  option :a2, :value => 2, :description => "Neutraal of enigszins ontevreden"
  option :a3, :value => 3, :description => "Redelijk tevreden"
  option :a4, :value => 4, :description => "Zeer tevreden"
end

question :v_6, :type => :radio do
  title "6. Heeft de zorg die u heeft ontvangen, u geholpen om beter met uw problemen om te gaan?"
  description ""
  option :a1, :value => 1, :description => "Nee, het lijkt er slechter van geworden"
  option :a2, :value => 2, :description => "Nee, het heeft niet geholpen"
  option :a3, :value => 3, :description => "Ja, het heeft iets geholpen"
  option :a4, :value => 4, :description => "Ja, het heeft veel geholpen"
end

question :v_7, :type => :radio do
  title "7. Hoe tevreden bent u in het algemeen met de zorg die u ontvangen heeft?"
  description ""
  option :a1, :value => 1, :description => "Nogal ontevreden"
  option :a2, :value => 2, :description => "Neutraal of enigszins ontevreden"
  option :a3, :value => 3, :description => "Redelijk tevreden"
  option :a4, :value => 4, :description => "Zeer tevreden"
end

question :v_8, :type => :radio do
  title "8. Zou u weer voor deze vorm van hulpverlening kiezen als u nog eens hulp nodig heeft?"
  description ""
  option :a1, :value => 1, :description => "Nee, beslist niet"
  option :a2, :value => 2, :description => "Nee, dat denk ik niet"
  option :a3, :value => 3, :description => "Ja, dat denk ik wel"
  option :a4, :value => 4, :description => "Ja, zeker"
end

question :v_10, :type => :open do
  title "Schrijf hier uw opmerkingen neer:"
  description ""
end

end_panel

