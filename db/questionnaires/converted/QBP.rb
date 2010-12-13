# QBP

# Project ID 577
# Date (GMT) 06-12-2010 20:55:00
# No values auto-recoded
# Manual recodes: nog veel nawerk nodig

key "qbp"
title "QBP"
description ""

start_panel

question :v_1, :type => :open do
  title "1. Wat is uw lengte?"
  description ""
end

question :v_1, :type => :open do
  title "%s cm"
  description ""
end

question :v_2, :type => :open do
  title "2. Wat is uw gewicht?"
  description ""
end

question :v_2, :type => :open do
  title "a. Momenteel:%s kg v_3"
  description ""
end

question :v_3, :type => :open do
  title "b. Normaal:%s kg v_4"
  description ""
end

question :v_4, :type => :open do
  title "c. Hoogste afgelopen jaar:%s kg v_5"
  description ""
end

question :v_5, :type => :open do
  title "d. Laagste afgelopen jaar:%s kg"
  description ""
end

question :v_6, :type => :radio do
  title "3. Wat is uw culturele herkomst?"
  description ""
  option :a1, :value => 1, :description => "Nederland"
  option :a2, :value => 2, :description => "Suriname / Nederlandse Antillen"
  option :a3, :value => 3, :description => "Turkije"
  option :a4, :value => 4, :description => "Marokko"
  option :a5, :value => 5, :description => "Azi'e"
  option :a6, :value => 6, :description => "Anders (Specificeer s.v.p):"
end

question :v_8, :type => :radio do
  title "4. Wat is uw huidige burgerlijke staat?"
  description ""
  option :a1, :value => 1, :description => "Getrouwd"
  option :a2, :value => 2, :description => "Samenwonend"
  option :a3, :value => 3, :description => "Alleenstaand"
  option :a4, :value => 4, :description => "Gescheiden"
  option :a5, :value => 5, :description => "Weduwe / weduwnaar"
end

question :v_9, :type => :radio do
  title "5. Wat is uw hoogst voltooide schoolopleiding?"
  description ""
  option :a1, :value => 1, :description => "Lagere school; basisonderwijs groep 3 en hoger; speciaal basisonderwijs"
  option :a2, :value => 2, :description => "Voortgezet lager onderwijs; lavo; lager beroepsonderwijs (b.v. vmbo, lts, lhno, huishoudschool, leao, lager land- en tuinbouwonderwijs); ulo, mulo/mavo; 3 jaar of minder havo/vwo; voortgezet speciaal onderwijs"
  option :a3, :value => 3, :description => "Middelbaar onderwijs: hbs, mms, gymnasium, havo 4 en 5, vwo 4 t/m 6; middelbaar beroepsonderwijs (b.v. mts, meao); leerlingwezen"
  option :a4, :value => 4, :description => "Hoger beroepsonderwijs (b.v. hts, heao, sociale academie, lerarenopleiding); wetenschappelijk onderwijs t/m propaedeuse of kandidaats"
  option :a5, :value => 5, :description => "Wetenschappelijk onderwijs (doctoraal, ingenieursopleiding); post hbo-onderwijs"
  option :a6, :value => 6, :description => "Tweede fase opleiding; post-doctorale opleiding; promotie"
end

question :v_10, :type => :radio do
  title "6a. Wat is de hoogst voltooide schoolopleiding van uw moeder?"
  description ""
  option :a1, :value => 1, :description => "Lagere school; basisonderwijs groep 3 en hoger; speciaal basisonderwijs"
  option :a2, :value => 2, :description => "Voortgezet lager onderwijs; lavo; lager beroepsonderwijs (b.v. vmbo, lts, lhno, huishoudschool, leao, lager land- en tuinbouwonderwijs); ulo, mulo/mavo; 3 jaar of minder havo/vwo; voortgezet speciaal onderwijs"
  option :a3, :value => 3, :description => "Middelbaar onderwijs: hbs, mms, gymnasium, havo 4 en 5, vwo 4 t/m 6; middelbaar beroepsonderwijs (b.v. mts, meao); leerlingwezen"
  option :a4, :value => 4, :description => "Hoger beroepsonderwijs (b.v. hts, heao, sociale academie, lerarenopleiding); wetenschappelijk onderwijs t/m propaedeuse of kandidaats"
  option :a5, :value => 5, :description => "Wetenschappelijk onderwijs (doctoraal, ingenieursopleiding); post hbo-onderwijs"
  option :a6, :value => 6, :description => "Tweede fase opleiding; post-doctorale opleiding; promotie"
end

question :v_11, :type => :radio do
  title "6b. Wat is de hoogst voltooide schoolopleiding van uw vader?"
  description ""
  option :a1, :value => 1, :description => "Lagere school; basisonderwijs groep 3 en hoger; speciaal basisonderwijs"
  option :a2, :value => 2, :description => "Voortgezet lager onderwijs; lavo; lager beroepsonderwijs (b.v. vmbo, lts, lhno, huishoudschool, leao, lager land- en tuinbouwonderwijs); ulo, mulo/mavo; 3 jaar of minder havo/vwo; voortgezet speciaal onderwijs"
  option :a3, :value => 3, :description => "Middelbaar onderwijs: hbs, mms, gymnasium, havo 4 en 5, vwo 4 t/m 6; middelbaar beroepsonderwijs (b.v. mts, meao); leerlingwezen"
  option :a4, :value => 4, :description => "Hoger beroepsonderwijs (b.v. hts, heao, sociale academie, lerarenopleiding); wetenschappelijk onderwijs t/m propaedeuse of kandidaats"
  option :a5, :value => 5, :description => "Wetenschappelijk onderwijs (doctoraal, ingenieursopleiding); post hbo-onderwijs"
  option :a6, :value => 6, :description => "Tweede fase opleiding; post-doctorale opleiding; promotie"
end

question :v_139, :type => :radio do
  title "7. Wat is uw huidige werksituatie?"
  description ""
  option :a0, :value => 0, :description => "Not quoted."
  option :a1, :value => 1, :description => "Quoted."
  option :a0, :value => 0, :description => "Not quoted."
  option :a1, :value => 1, :description => "Quoted."
  option :a0, :value => 0, :description => "Not quoted."
  option :a1, :value => 1, :description => "Quoted."
  option :a0, :value => 0, :description => "Not quoted."
  option :a1, :value => 1, :description => "Quoted."
  option :a0, :value => 0, :description => "Not quoted."
  option :a1, :value => 1, :description => "Quoted."
  option :a0, :value => 0, :description => "Not quoted."
  option :a1, :value => 1, :description => "Quoted."
  option :a0, :value => 0, :description => "Not quoted."
  option :a1, :value => 1, :description => "Quoted."
  option :a0, :value => 0, :description => "Not quoted."
  option :a1, :value => 1, :description => "Quoted."
  option :a0, :value => 0, :description => "Not quoted."
  option :a1, :value => 1, :description => "Quoted."
  option :a0, :value => 0, :description => "Not quoted."
  option :a1, :value => 1, :description => "Quoted."
  option :a0, :value => 0, :description => "Not quoted."
  option :a1, :value => 1, :description => "Quoted."
  option :a0, :value => 0, :description => "Not quoted."
  option :a1, :value => 1, :description => "Quoted."
  option :a0, :value => 0, :description => "Not quoted."
  option :a1, :value => 1, :description => "Quoted."
end

question :v_14, :type => :radio do
  title "8. In welke mate wordt uw beroepsmatig functioneren beperkt door uw manisch-depressieve stoornis?"
  description ""
  option :a1, :value => 1, :description => "Geen beperkingen"
  option :a2, :value => 2, :description => "Licht"
  option :a3, :value => 3, :description => "Matig"
  option :a4, :value => 4, :description => "Aanmerkelijk"
  option :a5, :value => 5, :description => "Ernstig"
end

question :v_29, :type => :radio do
  title "9. Hoe tevreden bent u over het algemeen met uw leven bij ziekte en gezondheid?"
  description ""
end

question :v_29, :type => :radio do
  title "a. Indien depressief"
  description ""
  option :a1, :value => 1, :description => "Erg ontevreden"
  option :a2, :value => 2, :description => "Ontevreden"
  option :a3, :value => 3, :description => "Enigszins ontevreden"
  option :a4, :value => 4, :description => "Neutraal"
  option :a5, :value => 5, :description => "Enigszins tevreden"
  option :a6, :value => 6, :description => "Tevreden"
  option :a7, :value => 7, :description => "Erg tevreden"
end

question :v_30, :type => :radio do
  title "b. Indien manisch"
  description ""
  option :a1, :value => 1, :description => "Erg ontevreden"
  option :a2, :value => 2, :description => "Ontevreden"
  option :a3, :value => 3, :description => "Enigszins ontevreden"
  option :a4, :value => 4, :description => "Neutraal"
  option :a5, :value => 5, :description => "Enigszins tevreden"
  option :a6, :value => 6, :description => "Tevreden"
  option :a7, :value => 7, :description => "Erg tevreden"
end

question :v_31, :type => :radio do
  title "c. Indien gezond"
  description ""
  option :a1, :value => 1, :description => "Erg ontevreden"
  option :a2, :value => 2, :description => "Ontevreden"
  option :a3, :value => 3, :description => "Enigszins ontevreden"
  option :a4, :value => 4, :description => "Neutraal"
  option :a5, :value => 5, :description => "Enigszins tevreden"
  option :a6, :value => 6, :description => "Tevreden"
  option :a7, :value => 7, :description => "Erg tevreden"
end

question :v_34, :type => :radio do
  title "10. Is er iemand van uw naaste familie (grootouders, ouders, broers en zussen, of kinderen) met een voorgeschiedenis van depressie (en geen manisch-depressieve stoornis, dus geen manie of hypomanie)?"
  description ""
end

question :v_34, :type => :radio do
  title "a. Moeder"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker(Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_35, :type => :radio do
  title "b. Grootmoeder van moederszijde"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker(Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_36, :type => :radio do
  title "c. Grootvader van moederszijde"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker(Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_37, :type => :radio do
  title "d. Vader"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker(Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_38, :type => :radio do
  title "e. Grootmoeder van vaderszijde"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker(Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_39, :type => :radio do
  title "f. Grootvader van vaderszijde"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker(Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_40, :type => :radio do
  title "10b. Is er iemand van uw naaste familie (grootouders, ouders, broers en zussen, of kinderen) met een voorgeschiedenis van depressie (en geen manisch-depressieve stoornis, dus geen manie of hypomanie)?"
  description ""
end

question :v_40, :type => :radio do
  title "g. Broers / zussen"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
  option :a6, :value => 6, :description => "N.v.t."
end

question :v_41, :type => :radio do
  title "h. Kinderen"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
  option :a6, :value => 6, :description => "N.v.t."
end

question :v_46, :type => :radio do
  title "11. Is er iemand van uw naaste familie (grootouders, ouders, broers en zussen, of kinderen) met een voorgeschiedenis van een manisch-depressieve (bipolaire) stoornis (voorgeschiedenis van manie of hypomanie)?"
  description ""
end

question :v_46, :type => :radio do
  title "a. Moeder"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_47, :type => :radio do
  title "b. Grootmoeder van moederszijde"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_48, :type => :radio do
  title "c. Grootvader van moederszijde"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_49, :type => :radio do
  title "d. Vader"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_50, :type => :radio do
  title "e. Grootmoeder van vaderszijde"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_51, :type => :radio do
  title "f. Grootvader van vaderszijde"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_52, :type => :radio do
  title "11b. Is er iemand van uw naaste familie (grootouders, ouders, broers en zussen, of kinderen) met een voorgeschiedenis van een manisch-depressieve (bipolaire) stoornis (voorgeschiedenis van manie of hypomanie)?"
  description ""
end

question :v_52, :type => :radio do
  title "g. Broers / zussen"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
  option :a6, :value => 6, :description => "N.v.t."
end

question :v_53, :type => :radio do
  title "h. Kinderen"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
  option :a6, :value => 6, :description => "N.v.t."
end

question :v_54, :type => :radio do
  title "12. Is er iemand van uw naaste familie (grootouders, ouders, broers en zussen, of kinderen) met een voorgeschiedenis van een psychose (bijvoorbeeld schizofrenie)?"
  description ""
end

question :v_54, :type => :radio do
  title "a. Moeder"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_55, :type => :radio do
  title "b. Grootmoeder van moederszijde"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_56, :type => :radio do
  title "c. Grootvader van moederszijde"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_57, :type => :radio do
  title "d. Vader"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_58, :type => :radio do
  title "e. Grootmoeder van vaderszijde"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_59, :type => :radio do
  title "f. Grootvader van vaderszijde"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_60, :type => :radio do
  title "12b. Is er iemand van uw naaste familie (grootouders, ouders, broers en zussen, of kinderen) met een voorgeschiedenis van een psychose (bijvoorbeeld schizofrenie)?"
  description ""
end

question :v_60, :type => :radio do
  title "g. Broers / zussen"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
  option :a6, :value => 6, :description => "N.v.t."
end

question :v_61, :type => :radio do
  title "h. Kinderen"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
  option :a6, :value => 6, :description => "N.v.t."
end

question :v_62, :type => :radio do
  title "13. Is er iemand van uw naaste familie (grootouders, ouders, broers en zussen, of kinderen) met een voorgeschiedenis van een su'icide en/of een ernstige su'icidepoging?"
  description ""
end

question :v_62, :type => :radio do
  title "a. Moeder"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_63, :type => :radio do
  title "b. Grootmoeder van moederszijde"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_64, :type => :radio do
  title "c. Grootvader van moederszijde"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_65, :type => :radio do
  title "d. Vader"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_66, :type => :radio do
  title "e. Grootmoeder van vaderszijde"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_67, :type => :radio do
  title "f. Grootvader van vaderszijde"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_68, :type => :radio do
  title "13b. Is er iemand van uw naaste familie (grootouders, ouders, broers en zussen, of kinderen) met een voorgeschiedenis van een su'icide en/of een ernstige su'icidepoging?"
  description ""
end

question :v_68, :type => :radio do
  title "g. Broers / zussen"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
  option :a6, :value => 6, :description => "N.v.t."
end

question :v_69, :type => :radio do
  title "h. Kinderen"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
  option :a6, :value => 6, :description => "N.v.t."
end

question :v_70, :type => :radio do
  title "14. Is er iemand van uw naaste familie (grootouders, ouders, broers en zussen, of kinderen) met een voorgeschiedenis van alcoholisme?"
  description ""
end

question :v_70, :type => :radio do
  title "a. Moeder"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_71, :type => :radio do
  title "b. Grootmoeder van moederszijde"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_72, :type => :radio do
  title "c. Grootvader van moederszijde"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_73, :type => :radio do
  title "d. Vader"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_74, :type => :radio do
  title "e. Grootmoeder van vaderszijde"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_75, :type => :radio do
  title "f. Grootvader van vaderszijde"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_76, :type => :radio do
  title "14b. Is er iemand van uw naaste familie (grootouders, ouders, broers en zussen, of kinderen) met een voorgeschiedenis van alcoholisme?"
  description ""
end

question :v_76, :type => :radio do
  title "g. Broers / zussen"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
  option :a6, :value => 6, :description => "N.v.t."
end

question :v_77, :type => :radio do
  title "h. Kinderen"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
  option :a6, :value => 6, :description => "N.v.t."
end

question :v_78, :type => :radio do
  title "15. Is er iemand van uw naaste familie (grootouders, ouders, broers en zussen, of kinderen) met een voorgeschiedenis van druggebruik of middelenmisbruik (gebruik van illegale drugs of misbruik van voorgeschreven medicatie)?"
  description ""
end

question :v_78, :type => :radio do
  title "a. Moeder"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_79, :type => :radio do
  title "b. Grootmoeder van moederszijde"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_80, :type => :radio do
  title "c. Grootvader van moederszijde"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_81, :type => :radio do
  title "d. Vader"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_82, :type => :radio do
  title "e. Grootmoeder van vaderszijde"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_83, :type => :radio do
  title "f. Grootvader van vaderszijde"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
end

question :v_84, :type => :radio do
  title "15b. Is er iemand van uw naaste familie (grootouders, ouders, broers en zussen, of kinderen) met een voorgeschiedenis van druggebruik of middelenmisbruik (gebruik van illegale drugs of misbruik van voorgeschreven medicatie)?"
  description ""
end

question :v_84, :type => :radio do
  title "g. Broers / zussen"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
  option :a6, :value => 6, :description => "N.v.t."
end

question :v_85, :type => :radio do
  title "h. Kinderen"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Mogelijk"
  option :a3, :value => 3, :description => "Waarschijnlijk"
  option :a4, :value => 4, :description => "Zeker (Diagnose gesteld of behandeld)"
  option :a5, :value => 5, :description => "Weet niet"
  option :a6, :value => 6, :description => "N.v.t."
end

question :v_86, :type => :open do
  title "16. Op welke leeftijd had u ..."
  description ""
end

question :v_86, :type => :open do
  title "a. Voor het eerst symptomen van depressie met invloed op uw functioneren:%s jaar v_87"
  description ""
end

question :v_87, :type => :open do
  title "b. Voor het eerst symptomen van hypomanie of manie:%s jaar"
  description ""
end

question :v_174, :type => :radio do
  title "16b. Op welke leeftijd had u ..."
  description ""
  option :a0, :value => 0, :description => "Not quoted."
  option :a1, :value => 1, :description => "Quoted."
  option :a0, :value => 0, :description => "Not quoted."
  option :a1, :value => 1, :description => "Quoted."
  option :a0, :value => 0, :description => "Not quoted."
  option :a1, :value => 1, :description => "Quoted."
  option :a0, :value => 0, :description => "Not quoted."
  option :a1, :value => 1, :description => "Quoted."
end

question :v_107, :type => :radio do
  title "17. Bent u ooit verbaal of emotioneel mishandeld (zoals intimidatie, bedreigingen, vernedering of ernstig uitschelden wat ernstige emotionele schade bij u veroorzaakte)?"
  description ""
end

question :v_107, :type => :radio do
  title "a. Als kind"
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Vaak"
end

question :v_108, :type => :radio do
  title "b. Als adolescent"
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Vaak"
end

question :v_109, :type => :radio do
  title "c. Als volwassene"
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Vaak"
end

question :v_110, :type => :radio do
  title "18. Bent u ooit lichamelijk aangevallen of mishandeld (d.w.z. zijn er ervaringen met lichamelijk letsel of schade toegebracht door een ander zoals door slaan, door stompen, door schoppen, door bijten, door branden, door wurgen of door een aanval met een wapen)?"
  description ""
end

question :v_110, :type => :radio do
  title "a. Als kind"
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Vaak"
end

question :v_111, :type => :radio do
  title "b. Als adolescent"
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Vaak"
end

question :v_112, :type => :radio do
  title "c. Als volwassene"
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Vaak"
end

question :v_113, :type => :radio do
  title "19. Bent u ooit aangerand of seksueel mishandeld (d.w.z. zijn er ervaringen met seksueel geweld, aanranding of gedwongen seksuele activiteiten)?"
  description ""
end

question :v_113, :type => :radio do
  title "a. Als kind"
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Vaak"
end

question :v_114, :type => :radio do
  title "b. Als adolescent"
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Vaak"
end

question :v_115, :type => :radio do
  title "c. Als volwassene"
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Zelden"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Vaak"
end

question :v_116, :type => :radio do
  title "20. Kunt u een schatting geven hoe vaak u het volgende in uw leven heeft meegemaakt?"
  description ""
end

question :v_116, :type => :radio do
  title "a. Hypomane/manische episodes"
  description ""
  option :a1, :value => 1, :description => "0"
  option :a2, :value => 2, :description => "1"
  option :a3, :value => 3, :description => "2"
  option :a4, :value => 4, :description => "3"
  option :a5, :value => 5, :description => "4"
  option :a6, :value => 6, :description => "5-10"
  option :a7, :value => 7, :description => "11-20"
  option :a8, :value => 8, :description => "Meer dan 20"
end

question :v_117, :type => :radio do
  title "b. Opnames voor manie"
  description ""
  option :a1, :value => 1, :description => "0"
  option :a2, :value => 2, :description => "1"
  option :a3, :value => 3, :description => "2"
  option :a4, :value => 4, :description => "3"
  option :a5, :value => 5, :description => "4"
  option :a6, :value => 6, :description => "5-10"
  option :a7, :value => 7, :description => "11-20"
  option :a8, :value => 8, :description => "Meer dan 20"
end

question :v_118, :type => :radio do
  title "c. Depressieve episodes"
  description ""
  option :a1, :value => 1, :description => "0"
  option :a2, :value => 2, :description => "1"
  option :a3, :value => 3, :description => "2"
  option :a4, :value => 4, :description => "3"
  option :a5, :value => 5, :description => "4"
  option :a6, :value => 6, :description => "5-10"
  option :a7, :value => 7, :description => "11-20"
  option :a8, :value => 8, :description => "Meer dan 20"
end

question :v_119, :type => :radio do
  title "d. Opnames voor depressie"
  description ""
  option :a1, :value => 1, :description => "0"
  option :a2, :value => 2, :description => "1"
  option :a3, :value => 3, :description => "2"
  option :a4, :value => 4, :description => "3"
  option :a5, :value => 5, :description => "4"
  option :a6, :value => 6, :description => "5-10"
  option :a7, :value => 7, :description => "11-20"
  option :a8, :value => 8, :description => "Meer dan 20"
end

question :v_120, :type => :radio do
  title "21. Rookt u gewoonlijk?"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Ja"
end

question :v_121, :type => :open do
  title "21b. Hoe veel rookt u?"
  description ""
end

question :v_121, :type => :open do
  title "(with type check: Integer) a. Gemiddeld aantal sigaretten per dag: v_122"
  description ""
end

question :v_122, :type => :open do
  title "(with type check: Integer) b. Gemiddeld aantal pijpen per dag: v_123"
  description ""
end

question :v_123, :type => :open do
  title "(with type check: Integer) c. Gemiddeld aantal sigaren per dag:"
  description ""
end

question :v_124, :type => :open do
  title "22. Hoe lang rookt u al?"
  description ""
end

question :v_125, :type => :radio do
  title "23. Heeft u eerder gerookt?"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Ja"
end

question :v_126, :type => :open do
  title "23b. Hoe veel rookte u?"
  description ""
end

question :v_126, :type => :open do
  title "(with type check: Integer) a. Gemiddeld aantal sigaretten per dag: v_127"
  description ""
end

question :v_127, :type => :open do
  title "(with type check: Integer) b. Gemiddeld aantal pijpen per dag: v_128"
  description ""
end

question :v_128, :type => :open do
  title "(with type check: Integer) c. Gemiddeld aantal sigaren per dag:"
  description ""
end

question :v_129, :type => :open do
  title "24. Hoe lang heeft u gerookt?"
  description ""
end

question :v_130, :type => :radio do
  title "25. Hoeveel kopjes cafe'ine bevattende koffie drinkt u gewoonlijk per dag?"
  description ""
  option :a1, :value => 1, :description => "Geen"
  option :a2, :value => 2, :description => "1-2"
  option :a3, :value => 3, :description => "3-4"
  option :a4, :value => 4, :description => "5-6"
  option :a5, :value => 5, :description => "7 of meer"
end

question :v_131, :type => :radio do
  title "26. Hoeveel andere cafe'ine bevattende drankjes (thee, cola etc.) drinkt u gewoonlijk per dag?"
  description ""
  option :a1, :value => 1, :description => "Geen"
  option :a2, :value => 2, :description => "1-2"
  option :a3, :value => 3, :description => "3-4"
  option :a4, :value => 4, :description => "5-6"
  option :a5, :value => 5, :description => "7 of meer"
end

question :v_132, :type => :radio do
  title "27. Gebruikt u gewoonlijk alcohol?"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Ja"
end

question :v_133, :type => :open do
  title "27b. Hoeveel alcohol gebruikt u?"
  description ""
end

question :v_134, :type => :open do
  title "28. Hoe lang gebruikt u al alcohol?"
  description ""
end

question :v_135, :type => :radio do
  title "29. Heeft u eerder alcohol gebruikt?"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Ja"
end

question :v_136, :type => :open do
  title "29b. Hoeveel alcohol gebruikte u?"
  description ""
end

question :v_137, :type => :open do
  title "30. Hoe lang heeft u alcohol gebruikt?"
  description ""
end

question :v_138, :type => :radio do
  title "31. Heeft u ooit te veel gedronken?"
  description ""
  option :a1, :value => 1, :description => "Nee"
  option :a2, :value => 2, :description => "Ja"
end

question :v_152, :type => :radio do
  title "32. Hoeveel lichaamsbeweging heeft u (d.w.z. lichaamsbeweging van ongeveer 20 minuten of meer zoals wandelen, zwemmen, fietsen, aerobic, hometrainer etc.)?"
  description ""
  option :a1, :value => 1, :description => "Helemaal niet"
  option :a2, :value => 2, :description => "Zelden (1 tot 2 keer per maand)"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Vaak (1 tot 2 keer per week)"
  option :a5, :value => 5, :description => "Erg vaak (3 tot 4 keer per week)"
  option :a6, :value => 6, :description => "Dagelijks"
end

question :v_153, :type => :radio do
  title "33. Hoe geregeld neemt u de door uw psychiater/arts voorgeschreven medicijnen in voor uw bipolaire ziekte?"
  description ""
  option :a1, :value => 1, :description => "Nooit medicijnen voorgeschreven gekregen voor behandeling van bipolaire stoornis"
  option :a2, :value => 2, :description => "Sla nooit of bijna nooit over"
  option :a3, :value => 3, :description => "Sla soms over ('e'en of twee keer per maand)"
  option :a4, :value => 4, :description => "Sla veelvuldig over (enkele keren per week)"
  option :a5, :value => 5, :description => "Sla vaak over"
end

question :v_154, :type => :radio do
  title "34. Hoe vaak heeft u zelfmoordgedachten gehad, gedurende uw depressieve episodes in het verleden?"
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Af en toe"
  option :a3, :value => 3, :description => "Vaak"
  option :a4, :value => 4, :description => "Voortdurend"
end

question :v_155, :type => :radio do
  title "35. Hoe vaak heeft u zelfmoordgedachten gehad, gedurende uw manische of gemengde episodes in het verleden?"
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Af en toe"
  option :a3, :value => 3, :description => "Vaak"
  option :a4, :value => 4, :description => "Voortdurend"
end

question :v_156, :type => :radio do
  title "36. Hoeveel ernstige zelfmoordpogingen (d.w.z. medische zorg noodzakelijk, Eerste Hulp bezoek of ziekenhuisopname noodzakelijk) heeft u in het verleden gedaan?"
  description ""
  option :a1, :value => 1, :description => "Geen"
  option :a2, :value => 2, :description => "E'en"
  option :a3, :value => 3, :description => "Twee"
  option :a4, :value => 4, :description => "Drie"
  option :a5, :value => 5, :description => "Vier of meer"
end

question :v_157, :type => :radio do
  title "37. In hoeverre heeft u op dit moment zelfmoordgedachten?"
  description ""
  option :a1, :value => 1, :description => "Helemaal niet"
  option :a2, :value => 2, :description => "Licht (korte vluchtige gedachten over zelfmoord of af en toe gedachten dat het beter zou zijn om dood te zijn)"
  option :a3, :value => 3, :description => "Matig (veelvuldig gedachten over zelfmoord en/of begonnen met het bedenken van plannen over zelfdoding)"
  option :a4, :value => 4, :description => "Ernstig (constant denken over zelfmoord of voorbereidingen getroffen voor een serieuze zelfmoordpoging)"
end

question :v_158, :type => :radio do
  title "38. In welke mate is stigmatisering door bipolaire ziekte van invloed op u?"
  description ""
  option :a1, :value => 1, :description => "Helemaal niet (kan gemakkelijk mijn diagnose bekend maken aan bijna alle familieleden, vrienden en collega's)"
  option :a2, :value => 2, :description => "Licht (kan gemakkelijk mijn diagnose bekend maken aan de meeste, maar niet alle familieleden, vrienden en collega's)"
  option :a3, :value => 3, :description => "Matig (kan gemakkelijk mijn diagnose bekend maken aan een klein aantal familieleden, vrienden en collega's)"
  option :a4, :value => 4, :description => "Ernstig (kan mijn diagnose bekend maken aan bijna niemand van mijn familie, vrienden en collega's)"
end

question :v_159, :type => :radio do
  title "39. Vink alle informatiebronnen aan die u heeft gebruikt bij het invullen van deze vragenlijst :"
  description ""
  option :a0, :value => 0, :description => "Not quoted."
  option :a1, :value => 1, :description => "Quoted."
  option :a0, :value => 0, :description => "Not quoted."
  option :a1, :value => 1, :description => "Quoted."
  option :a0, :value => 0, :description => "Not quoted."
  option :a1, :value => 1, :description => "Quoted."
  option :a0, :value => 0, :description => "Not quoted."
  option :a1, :value => 1, :description => "Quoted."
  option :a0, :value => 0, :description => "Not quoted."
  option :a1, :value => 1, :description => "Quoted."
  option :a0, :value => 0, :description => "Not quoted."
  option :a1, :value => 1, :description => "Quoted."
  option :a0, :value => 0, :description => "Not quoted."
  option :a1, :value => 1, :description => "Quoted."
  option :a0, :value => 0, :description => "Not quoted."
  option :a1, :value => 1, :description => "Quoted."
end

question :v_168, :type => :radio do
  title "40. In overweging nemend dat wij u tal van gedetailleerde vragen hebben gesteld met betrekking tot uw ziekte, sociaal en beroepsmatig functioneren, familiegegevens etc., hoe zou u uw antwoorden omschrijven?"
  description ""
  option :a1, :value => 1, :description => "Erg nauwkeurig"
  option :a2, :value => 2, :description => "Veelal nauwkeurig"
  option :a3, :value => 3, :description => "Enigszins nauwkeurig"
  option :a4, :value => 4, :description => "Veelal gissingen"
end

end_panel

