# Klanttevredenheidslijst

# Project ID 732
# Date (GMT) 06-12-2010 20:51:52
# No values auto-recoded
# Manual recodes: 41,42,43,44,45,46,47,48,49,50,59:2-;57:3-

key "klant_tevreden"
title "Klanttevredenheidslijst"
description ""

panel do
 title "De Klanttevredenheidslijst"
 text "We zouden het op prijs stellen als u ons wilt helpen om onze hulpverlening te verbeteren. U kunt dat doen door enkele vragen te beantwoorden over de hulpverlening die u heeft ontvangen. We willen graag uw eerlijke mening, of deze nu positief of negatief is.

Deze vragenlijst bevat 23 vragen.

Klik op 'Volgende vraag' om verder te gaan."

question :v_60, :type => :radio do
  title "Vindt u het goed dat uw behandelaar inzage krijgt in de antwoorden die u geeft op deze klanttevredenheidslijst?"
  description ""
  option :a1, :value => 1, :description => "Ja, mijn behandelaar mag inzage krijgen in mijn antwoorden en deze met mij bespreken."
  option :a2, :value => 2, :description => "Nee, mijn antwoorden dienen anoniem te blijven (uw oordeel telt wel mee in de beoordeling van de behandeling die u heeft gehad)."
end
end

panel do
question :v_2, :type => :radio do
  title "1. Hoe beoordeelt u de kwaliteit van de door u ontvangen zorg?"
  description ""
  option :a1, :value => 1, :description => "Slecht"
  option :a2, :value => 2, :description => "Redelijk"
  option :a3, :value => 3, :description => "Goed"
  option :a4, :value => 4, :description => "Uitstekend"
end

question :v_6, :type => :radio do
  title "2. Kreeg u het soort zorg dat u wilde?"
  description ""
  option :a1, :value => 1, :description => "Nee, beslist niet"
  option :a2, :value => 2, :description => "Nee, niet echt"
  option :a3, :value => 3, :description => "Ja, in het algemeen wel"
  option :a4, :value => 4, :description => "Ja, zeker"
end

question :v_14, :type => :radio do
  title "3. In hoeverre kwam ons aanbod tegemoet aan uw behoeften aan zorg?"
  description ""
  option :a1, :value => 1, :description => "Geen van mijn zorgbehoeften zijn vervuld"
  option :a2, :value => 2, :description => "Slechts enkele van mijn zorgbehoeften zijn vervuld"
  option :a3, :value => 3, :description => "De meeste van mijn zorgbehoeften zijn vervuld"
  option :a4, :value => 4, :description => "Bijna al mijn zorgbehoeften zijn vervuld"
end

question :v_16, :type => :radio do
  title "4. Als een vriend vergelijkbare hulp nodig had, zou u onze hulpverlening dan aanraden?"
  description ""
  option :a1, :value => 1, :description => "Nee, beslist niet"
  option :a2, :value => 2, :description => "Nee, dat denk ik niet"
  option :a3, :value => 3, :description => "Ja, dat denk ik wel"
  option :a4, :value => 4, :description => "Ja, zeker"
end
question :v_21, :type => :radio do
  title "5. Hoe tevreden bent u met de hoeveelheid hulp die u heeft gekregen?"
  description ""
  option :a1, :value => 1, :description => "Behoorlijk ontevreden"
  option :a2, :value => 2, :description => "Neutraal of enigszins ontevreden"
  option :a3, :value => 3, :description => "Redelijk tevreden"
  option :a4, :value => 4, :description => "Zeer tevreden"
end
end

panel do
question :v_29, :type => :radio do
  title "6. Heeft de zorg die u heeft ontvangen, u geholpen om beter met uw problemen om te gaan?"
  description ""
  option :a1, :value => 1, :description => "Nee, het lijkt er slechter van geworden"
  option :a2, :value => 2, :description => "Nee, het heeft niet geholpen"
  option :a3, :value => 3, :description => "Ja, het heeft iets geholpen"
  option :a4, :value => 4, :description => "Ja, het heeft veel geholpen"
end

question :v_58, :type => :radio do
  title "7. Bent u door de behandeling of begeleiding voldoende vooruitgegaan?"
  description ""
  option :a1, :value => 1, :description => "Nee, het lijkt er slechter van geworden"
  option :a2, :value => 2, :description => "Nee, het heeft niet geholpen"
  option :a3, :value => 3, :description => "Ja, het heeft iets geholpen"
  option :a4, :value => 4, :description => "Ja, het heeft veel geholpen"
end

question :v_34, :type => :radio do
  title "8. Hoe tevreden bent u in het algemeen met de zorg die u ontvangen heeft?"
  description ""
  option :a1, :value => 1, :description => "Nogal ontevreden"
  option :a2, :value => 2, :description => "Neutraal of enigszins ontevreden"
  option :a3, :value => 3, :description => "Redelijk tevreden"
  option :a4, :value => 4, :description => "Zeer tevreden"
end

question :v_36, :type => :radio do
  title "9. Zou u weer voor deze vorm van hulpverlening kiezen als u nog eens hulp nodig heeft?"
  description ""
  option :a1, :value => 1, :description => "Nee, beslist niet"
  option :a2, :value => 2, :description => "Nee, dat denk ik niet"
  option :a3, :value => 3, :description => "Ja, dat denk ik wel"
  option :a4, :value => 4, :description => "Ja, zeker"
end

question :v_41, :type => :radio do
  title "10. Kreeg u genoeg informatie over de verschillende mogelijkheden om u te helpen?"
  description ""
  option :a1, :value => 1, :description => "Ja"
  option :a2, :value => 0, :description => "Nee"
end
end

panel do
question :v_42, :type => :radio do
  title "11. Kreeg u genoeg informatie over de manier van behandelen?"
  description ""
  option :a1, :value => 1, :description => "Ja"
  option :a2, :value => 0, :description => "Nee"
end

question :v_43, :type => :radio do
  title "12. Kreeg u genoeg informatie over de resultaten die men wilde bereiken met uw behandeling?"
  description ""
  option :a1, :value => 1, :description => "Ja"
  option :a2, :value => 0, :description => "Nee"
end

question :v_57, :type => :radio do
  title "13. Bent u voldoende ge'informeerd over de (lichamelijke) bijwerkingen van de medicijnen die u gebruikt?"
  description ""
  option :a1, :value => 2, :description => "N.v.t."
  option :a2, :value => 1, :description => "Ja"
  option :a3, :value => 0, :description => "Nee"
end

question :v_44, :type => :radio do
  title "14. Kon u meebeslissen over uw behandeling?"
  description ""
  option :a1, :value => 1, :description => "Ja"
  option :a2, :value => 0, :description => "Nee"
end

question :v_45, :type => :radio do
  title "15. Werd u de mogelijkheid geboden een eigen behandelaar te kiezen?"
  description ""
  option :a1, :value => 1, :description => "Ja"
  option :a2, :value => 0, :description => "Nee"
end
end

panel do
question :v_46, :type => :radio do
  title "16. Is er een behandelingsplan gemaakt?"
  description ""
  option :a1, :value => 1, :description => "Ja"
  option :a2, :value => 0, :description => "Nee"
end

question :v_47, :type => :radio do
  title "17. Heeft u toestemming gegeven voor dit plan?"
  description ""
  option :a1, :value => 1, :description => "Ja"
  option :a2, :value => 0, :description => "Nee"
end

question :v_59, :type => :radio do
  title "18. Is het behandelplan naar wens uitgevoerd?"
  description ""
  option :a1, :value => 1, :description => "Ja"
  option :a2, :value => 0, :description => "Nee"
end

question :v_48, :type => :radio do
  title "19. Vond u de behandelaar deskundig?Met 'deskundig' bedoelen we goed zijn in je vak."
  description ""
  option :a1, :value => 1, :description => "Ja"
  option :a2, :value => 0, :description => "Nee"
end

question :v_49, :type => :radio do
  title "20. Toonde de hulpverlener genoeg respect voor u?"
  description ""
  option :a1, :value => 1, :description => "Ja"
  option :a2, :value => 0, :description => "Nee"
end

question :v_50, :type => :radio do
  title "21. Was de behandelaar genoeg ge'interesseerd in u en in uw mening?"
  description ""
  option :a1, :value => 1, :description => "Ja"
  option :a2, :value => 0, :description => "Nee"
end
end

panel do
question :v_52, :type => :radio do
  title "22. Welk rapportcijfer geeft u de totale behandeling?"
  description ""
  option :a1, :value => 1, :description => "1"
  option :a2, :value => 2, :description => "2"
  option :a3, :value => 3, :description => "3"
  option :a4, :value => 4, :description => "4"
  option :a5, :value => 5, :description => "5"
  option :a6, :value => 6, :description => "6"
  option :a7, :value => 7, :description => "7"
  option :a8, :value => 8, :description => "8"
  option :a9, :value => 9, :description => "9"
  option :a10, :value => 10, :description => "10"
end

question :v_53, :type => :string do
  title "23. Wat moet de instelling verbeteren?"
  description ""
end
end
end_panel

