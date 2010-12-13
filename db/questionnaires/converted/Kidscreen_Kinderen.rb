# Kidscreen Kinderen

# Project ID 583
# Date (GMT) 06-12-2010 20:49:23
# No values auto-recoded
# Manual recodes: 3-1

key "kidscreen_kinderen"
title "Kidscreen Kinderen"
description ""

start_panel

question :v_1, :type => :radio do
  title "1. Ben je een meisje of een jongen?"
  description ""
  option :a1, :value => 1, :description => "Meisje"
  option :a2, :value => 2, :description => "Jongen"
end

question :v_2, :type => :open do
  title "2. Hoeveel jaar ben je?"
  description ""
end

question :v_3, :type => :radio do
  title "3. Heb je een (langdurige) chronische ziekte of handicap?"
  description ""
  option :a1, :value => 0, :description => "Nee"
  option :a2, :value => 1, :description => "Ja, namelijk %s"
end

question :v_999999, :type => :open do
  title "Namelijk:"
  description ""
end

question :v_5, :type => :radio do
  title "4. Hoe is je gezondheid in het algemeen?"
  description ""
  option :a1, :value => 1, :description => "Heel erg goed"
  option :a2, :value => 2, :description => "Erg goed"
  option :a3, :value => 3, :description => "Goed"
  option :a4, :value => 4, :description => "Redelijk"
  option :a5, :value => 5, :description => "Slecht"
end

question :v_6, :type => :radio do
  title "5. Heb je je fit en gezond gevoeld?"
  description ""
  option :a1, :value => 1, :description => "Helemaal niet"
  option :a2, :value => 2, :description => "Bijna niet"
  option :a3, :value => 3, :description => "Gemiddeld"
  option :a4, :value => 4, :description => "Nogal"
  option :a5, :value => 5, :description => "Helemaal"
end

question :v_7, :type => :radio do
  title "6. Ben je lichamelijk actief geweest (bijv. hardlopen, klimmen, fietsen)?"
  description ""
  option :a1, :value => 1, :description => "Helemaal niet"
  option :a2, :value => 2, :description => "Bijna niet"
  option :a3, :value => 3, :description => "Gemiddeld"
  option :a4, :value => 4, :description => "Nogal"
  option :a5, :value => 5, :description => "Helemaal"
end

question :v_8, :type => :radio do
  title "7. Heb je goed kunnen rennen?"
  description ""
  option :a1, :value => 1, :description => "Helemaal niet"
  option :a2, :value => 2, :description => "Bijna niet"
  option :a3, :value => 3, :description => "Gemiddeld"
  option :a4, :value => 4, :description => "Nogal"
  option :a5, :value => 5, :description => "Helemaal"
end

question :v_9, :type => :radio do
  title "8. Heb je je vol energie gevoeld?"
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Bijna nooit"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Redelijk vaak"
  option :a5, :value => 5, :description => "Altijd"
end

question :v_10, :type => :radio do
  title "9. Is je leven plezierig geweest?"
  description ""
  option :a1, :value => 1, :description => "Helemaal niet"
  option :a2, :value => 2, :description => "Bijna niet"
  option :a3, :value => 3, :description => "Gemiddeld"
  option :a4, :value => 4, :description => "Nogal"
  option :a5, :value => 5, :description => "Helemaal"
end

question :v_11, :type => :radio do
  title "10. Ben je in een goed humeur geweest?"
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Bijna nooit"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Redelijk vaak"
  option :a5, :value => 5, :description => "Altijd"
end

question :v_12, :type => :radio do
  title "11. Heb je lol gehad?"
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Bijna nooit"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Redelijk vaak"
  option :a5, :value => 5, :description => "Altijd"
end

question :v_13, :type => :radio do
  title "12. Heb je je verdrietig gevoeld?"
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Bijna nooit"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Redelijk vaak"
  option :a5, :value => 5, :description => "Altijd"
end

question :v_14, :type => :radio do
  title "13. Heb je je zo naar gevoeld dat je helemaal niks wilde doen?"
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Bijna nooit"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Redelijk vaak"
  option :a5, :value => 5, :description => "Altijd"
end

question :v_15, :type => :radio do
  title "14. Heb je je eenzaam gevoeld?"
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Bijna nooit"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Redelijk vaak"
  option :a5, :value => 5, :description => "Altijd"
end

question :v_16, :type => :radio do
  title "15. Ben je tevreden geweest met jezelf?"
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Bijna nooit"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Redelijk vaak"
  option :a5, :value => 5, :description => "Altijd"
end

question :v_17, :type => :radio do
  title "16. Heb je voldoende tijd voor jezelf gehad?"
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Bijna nooit"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Redelijk vaak"
  option :a5, :value => 5, :description => "Altijd"
end

question :v_18, :type => :radio do
  title "17. Heb je in je vrije tijd de dingen kunnen doen die je wilt doen?"
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Bijna nooit"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Redelijk vaak"
  option :a5, :value => 5, :description => "Altijd"
end

question :v_19, :type => :radio do
  title "18. Hebben je ouders voldoende tijd voor je gehad?"
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Bijna nooit"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Redelijk vaak"
  option :a5, :value => 5, :description => "Altijd"
end

question :v_20, :type => :radio do
  title "19. Hebben je ouders je eerlijk behandeld?"
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Bijna nooit"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Redelijk vaak"
  option :a5, :value => 5, :description => "Altijd"
end

question :v_21, :type => :radio do
  title "20. Heb je met je ouders kunnen praten als je dat wilde?"
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Bijna nooit"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Redelijk vaak"
  option :a5, :value => 5, :description => "Altijd"
end

question :v_22, :type => :radio do
  title "21. Heb je genoeg geld gehad om dezelfde dingen te doen als je vrienden?"
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Bijna nooit"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Redelijk vaak"
  option :a5, :value => 5, :description => "Altijd"
end

question :v_23, :type => :radio do
  title "22. Heb je genoeg geld gehad voor je uitgaven?"
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Bijna nooit"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Redelijk vaak"
  option :a5, :value => 5, :description => "Altijd"
end

question :v_24, :type => :radio do
  title "23. Heb je tijd doorgebracht met je vrienden?"
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Bijna nooit"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Redelijk vaak"
  option :a5, :value => 5, :description => "Altijd"
end

question :v_25, :type => :radio do
  title "24. Heb je plezier gehad met je vrienden?"
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Bijna nooit"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Redelijk vaak"
  option :a5, :value => 5, :description => "Altijd"
end

question :v_26, :type => :radio do
  title "25. Hebben jij en je vrienden elkaar geholpen?"
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Bijna nooit"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Redelijk vaak"
  option :a5, :value => 5, :description => "Altijd"
end

question :v_27, :type => :radio do
  title "26. Heb je op je vrienden kunnen vertrouwen?"
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Bijna nooit"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Redelijk vaak"
  option :a5, :value => 5, :description => "Altijd"
end

question :v_28, :type => :radio do
  title "27. Heb je het naar je zin gehad op school?"
  description ""
  option :a1, :value => 1, :description => "Helemaal niet"
  option :a2, :value => 2, :description => "Bijna niet"
  option :a3, :value => 3, :description => "Gemiddeld"
  option :a4, :value => 4, :description => "Nogal"
  option :a5, :value => 5, :description => "Helemaal"
end

question :v_29, :type => :radio do
  title "28. Is het goed gegaan op school?"
  description ""
  option :a1, :value => 1, :description => "Helemaal niet"
  option :a2, :value => 2, :description => "Bijna niet"
  option :a3, :value => 3, :description => "Gemiddeld"
  option :a4, :value => 4, :description => "Nogal"
  option :a5, :value => 5, :description => "Helemaal"
end

question :v_30, :type => :radio do
  title "29. Heb je goed kunnen opletten?"
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Bijna nooit"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Redelijk vaak"
  option :a5, :value => 5, :description => "Altijd"
end

question :v_31, :type => :radio do
  title "30. Kon je goed overweg met de leraren?"
  description ""
  option :a1, :value => 1, :description => "Nooit"
  option :a2, :value => 2, :description => "Bijna nooit"
  option :a3, :value => 3, :description => "Soms"
  option :a4, :value => 4, :description => "Redelijk vaak"
  option :a5, :value => 5, :description => "Altijd"
end

end_panel

