# HoNOSNAH

# Project ID 735
# Date (GMT) 06-12-2010 20:46:11
# All values between 1 and 10 auto-recoded with -1
# Manual recodes: 85+1

key "honosnah"
title "HoNOS NAH"
description ""

start_panel

question :v_1, :type => :radio do
  title "SCHAAL 1. GEDRAGSSTOORNISSEN"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Geringe hyperactiviteit"
  option :a3, :value => 2, :description => "Duidelijk aanwezige hyperactiviteit"
  option :a4, :value => 3, :description => "Aanhoudende hyperactiviteit"
  option :a5, :value => 4, :description => "Ernstige hyperactiviteit"
  option :a10, :value => 9, :description => ""
end

question :v_13, :type => :radio do
  title "b) Agressief"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Soms prikkelbaar/ruzie"
  option :a3, :value => 2, :description => "Verbaal dreigen - duwen - vervelend - bemoeizuchtig (bijv. agressieve gebaren)"
  option :a4, :value => 3, :description => "Vaak verbaal dreigen/fysieke agressie jegens anderen"
  option :a5, :value => 4, :description => "Ten minste 1 ernstige fysieke aanval / aanhoudend en ernstig dreigend gedrag"
  option :a10, :value => 9, :description => ""
end

question :v_23, :type => :radio do
  title "c) Storend of destructief jegens personen of zaken"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Geen"
  option :a3, :value => 2, :description => "Lichte schade aan eigendommen (bijv. gebroken kopje/raam)"
  option :a4, :value => 3, :description => "Grote schade aan eigendommen (ernstiger)"
  option :a5, :value => 4, :description => "Ernstige/ blijvende schade (bijv. brandstichting)"
  option :a10, :value => 9, :description => ""
end

question :v_24, :type => :radio do
  title "d) Rusteloosheid"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Met tussenpozen"
  option :a4, :value => 3, :description => "Vaak"
  option :a5, :value => 4, :description => "Praktisch voortdurend"
  option :a10, :value => 9, :description => ""
end

question :v_25, :type => :radio do
  title "e) Agitatie"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Geen"
  option :a3, :value => 2, :description => "Duidelijk aanwezige agitatie"
  option :a4, :value => 3, :description => "Aanhoudend"
  option :a5, :value => 4, :description => "Ernstige agitatie"
  option :a10, :value => 9, :description => ""
end

question :v_26, :type => :radio do
  title "f) Weglopen"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Geen/soms"
  option :a3, :value => 2, :description => "Met tussenpozen (overdag of 's nachts)"
  option :a4, :value => 3, :description => "Vaker (overdag en 's nachts)"
  option :a5, :value => 4, :description => "Praktisch voortdurend"
  option :a10, :value => 9, :description => ""
end

question :v_27, :type => :radio do
  title "g) Ongepast en niet-co'operatief gedrag"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Soms"
  option :a3, :value => 2, :description => "Met tussenpozen, waardoor stimulering en overreding nodig zijn"
  option :a4, :value => 3, :description => "Aanhoudend duidelijk niet-co'operatief gedrag wat niet te doorbreken is"
  option :a5, :value => 4, :description => "Ernstig en onverdraaglijk voor anderen (bijv. doelbewust ongepast urineren of defeaceren)"
  option :a10, :value => 9, :description => ""
end

question :v_28, :type => :radio do
  title "h) Ongeremd gedrag(bijv. seksueel)"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "2"
  option :a3, :value => 2, :description => "Opdringerig gedrag"
  option :a4, :value => 3, :description => "Verbaal seksueel ontremd"
  option :a5, :value => 4, :description => "Seksueel ontremd"
  option :a10, :value => 9, :description => ""
end

question :v_32, :type => :radio do
  title "SCHAAL 2. OPZETTELIJKE ZELFVERWONDING"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Voorbijgaande gedachten over zelfbeschadiging, maar geen of weinig risico"
  option :a3, :value => 2, :description => "Soms gedachten over zelfbeschadiging (actief of passief)"
  option :a4, :value => 3, :description => "Vaak gedachten over zelfbeschadiging inclusief plannen maken"
  option :a5, :value => 4, :description => "Hardnekkige en ernstige gedachten over zelfbeschadiging"
  option :a10, :value => 9, :description => ""
end

question :v_33, :type => :radio do
  title "b) Intentie"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Geen"
  option :a3, :value => 2, :description => "Licht risico, zoals geen maatregelen nemen bij potentieel levensbedreigende situaties (bijv. bij het oversteken van een weg)"
  option :a4, :value => 3, :description => "Matig risico in de betreffende periodeVoorbereidend gedrag (bijv. pillen verzamelen)"
  option :a5, :value => 4, :description => "Ernstig risico op zelfbeschadiging in de referentieperiode"
  option :a10, :value => 9, :description => ""
end

question :v_34, :type => :radio do
  title "c) Daden"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Geen"
  option :a3, :value => 2, :description => "Geen"
  option :a4, :value => 3, :description => "Lichte zelfverwondingen"
  option :a5, :value => 4, :description => "Ten minste 'e'en poging tot zelfbeschadiging in de betreffende periode"
  option :a10, :value => 9, :description => ""
end

question :v_43, :type => :radio do
  title "SCHAAL 3. PROBLEMEN MET ALCOHOL- OF DRUGSGEBRUIK"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Geen"
  option :a3, :value => 2, :description => "Lichte mate"
  option :a4, :value => 3, :description => "Aanmerkelijk verlangen of afhankelijkheid"
  option :a5, :value => 4, :description => "Ernstig verlangen en afhankelijkheid"
  option :a10, :value => 9, :description => ""
end

question :v_44, :type => :radio do
  title "b) Alcohol of drugs krijgen prioriteit"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Geen"
  option :a3, :value => 2, :description => "Tamelijk vaak"
  option :a4, :value => 3, :description => "Aanhoudend"
  option :a5, :value => 4, :description => "Volledig"
  option :a10, :value => 9, :description => ""
end

question :v_45, :type => :radio do
  title "c) Controleverlies"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Kan onder controle houden"
  option :a3, :value => 2, :description => "Enig controleverlies"
  option :a4, :value => 3, :description => "Matig controleverlies"
  option :a5, :value => 4, :description => "Ernstig/ aanhoudend controleverlies"
  option :a10, :value => 9, :description => ""
end

question :v_46, :type => :radio do
  title "d) Frequentie van onder invloed zijn"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Niet duidelijk aanwezig"
  option :a3, :value => 2, :description => "Regelmatig - ong. 2-3 keer per week"
  option :a4, :value => 3, :description => "Vaker - ong. 4-5 keer per week"
  option :a5, :value => 4, :description => "Aanhoudend - dagelijks"
  option :a10, :value => 9, :description => ""
end

question :v_48, :type => :radio do
  title "e) Tijdelijke effecten"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Zelden"
  option :a3, :value => 2, :description => "Af en toe een kater"
  option :a4, :value => 3, :description => "Vaak een kater"
  option :a5, :value => 4, :description => "Ernstige belemmering vanwege alcohol/ drugsproblemen"
  option :a10, :value => 9, :description => ""
end

question :v_54, :type => :radio do
  title "SCHAAL 4. COGNITIEVE PROBLEMEN"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Enige mate van vergeet- achtigheid maar kan nieuwe dingen leren"
  option :a3, :value => 2, :description => "Duidelijke problemen met zich nieuwe informatie herinneren (bijv. namen of recente gebeurtenissen)Tekort heeft invloed op dagelijkse activiteitenEnige moeite met de weg vinden in een nieuwe of onbekende omgeving"
  option :a4, :value => 3, :description => "Kan geen nieuwe informatie onthouden (onthoudt alleen materiaal dat steeds wordt herhaald); perseveraties verstoren soms het denken"
  option :a5, :value => 4, :description => "Ernstige beperking (bijv. Er zijn alleen nog fragmenten over; verlies van zowel oude als recente informatie; kan geen nieuwe informatie leren; kan geen goede vrienden/familie herkennen of noemen.)"
  option :a10, :value => 9, :description => ""
end

question :v_55, :type => :radio do
  title "b) Ori'entatie"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Enige moeite met ori'enteren in tijd"
  option :a3, :value => 2, :description => "Vaak gedesori'enteerd in tijd"
  option :a4, :value => 3, :description => "Meestal gedesori'enteerd in tijd en vaak in plaats en soms in persoon"
  option :a5, :value => 4, :description => "Voortdurend gedesori'enteerd in tijd, plaats en persoon"
  option :a10, :value => 9, :description => ""
end

question :v_56, :type => :radio do
  title "c) Taal"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Af en toe versprekingen, maar zonder dat dit ten koste gaat van de betekenis. Geen problemen met taalgebruik"
  option :a3, :value => 2, :description => "Kan eenvoudige verbale informatie aan, maar enige moeite met begripMoeite met meer complex expressief taalgebruik"
  option :a4, :value => 3, :description => "Ernstige problemen met taal (expressief en/of receptief)"
  option :a5, :value => 4, :description => "Geen effectieve communicatie mogelijk via taal"
  option :a10, :value => 9, :description => ""
end

  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Enigszins afleidbaar en zeer lichte concentratiestoornissen"
  option :a3, :value => 2, :description => "Aandachtsspanne is beperkt"
  option :a4, :value => 3, :description => "Heeft door aandachtsproblemen moeite met helder denken"
  option :a5, :value => 4, :description => "Het denken is verstoord"
  option :a10, :value => 9, :description => ""

question :v_96, :type => :radio do
  title "int e) Planning en organisatie"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Enige problemen met het stellen van prioriteiten; geen twee dingen tegelijk kunnen doen"
  option :a3, :value => 2, :description => "Problemen met het plannen en uitvoeren van complexe taken"
  option :a4, :value => 3, :description => "Verdwaalt in een bekende omgeving. Moeite met plannen in alledaagse activiteiten"
  option :a5, :value => 4, :description => "Nauwelijks in staat tot de meest simpele taken (bijv. thee zetten)"
  option :a10, :value => 9, :description => ""
end

question :v_60, :type => :radio do
  title "SCHAAL 5. PROBLEMEN DIE VERBAND HOUDEN MET LICHAMELIJKE ZIEKTE/HANDICAP"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Bijv. oude blauwe plekken door vallen enz., die snel overgaan (bijv. pati'ent knapt iets op tijdens langdurige ziekte, zoals artritis)"
  option :a3, :value => 2, :description => "Lichte luchtweginfectie of urineweginfectieEnigermate verlies van on- afhankelijkheid"
  option :a4, :value => 3, :description => "Meer ernstige luchtweginfectie of urineweginfectie + incontinentie"
  option :a5, :value => 4, :description => "Ernstige infecties die leiden tot bedlegerigheid"
  option :a10, :value => 9, :description => ""
end

question :v_61, :type => :radio do
  title "b) Mobiliteit"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Enige beperking"
  option :a3, :value => 2, :description => "Loopafstand beperkt (zonder hulpmiddelen)"
  option :a4, :value => 3, :description => "Loopt alleen met hulp(middel)"
  option :a5, :value => 4, :description => "Gebonden aan bed/stoel"
  option :a10, :value => 9, :description => ""
end

question :v_62, :type => :radio do
  title "c) Zintuiglijke beperking"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Enige beperking maar kan effectief functioneren (bijv. bril of gehoorapparaat)"
  option :a3, :value => 2, :description => "Gezichts- of gehoor- beperkingen ondanks hulpmiddelen (bijv. bril of gehoorapparaat)"
  option :a4, :value => 3, :description => "Matige beperking"
  option :a5, :value => 4, :description => "Ernstige beperking - (bijv. officieel blind en doof)"
  option :a10, :value => 9, :description => ""
end

question :v_63, :type => :radio do
  title "d) Vallen"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Geen"
  option :a3, :value => 2, :description => "Mogelijkheid van, of laag risico op, vallen; tot op heden niet gevallen (onvast)"
  option :a4, :value => 3, :description => "Duidelijk aanwezig risico op vallen; al 1 of meer keren gevallen"
  option :a5, :value => 4, :description => "Hoog risico op vallen; al 1 of meer keren gevallen vanwege lichamelijke ziekte/handicap"
  option :a10, :value => 9, :description => ""
end

question :v_64, :type => :radio do
  title "e) Bijwerkingen van medicijnen"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Geen"
  option :a3, :value => 2, :description => "Licht"
  option :a4, :value => 3, :description => "Matig"
  option :a5, :value => 4, :description => "Ernstig"
  option :a10, :value => 9, :description => ""
end

question :v_65, :type => :radio do
  title "f) Pijn vanwege lichamelijke ziekte"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Geen"
  option :a3, :value => 2, :description => "Lichte mate van pijn"
  option :a4, :value => 3, :description => "Enige mate van pijn"
  option :a5, :value => 4, :description => "Ernstige pijn/problemen die gepaard gaan met pijn"
  option :a10, :value => 9, :description => ""
end

question :v_66, :type => :radio do
  title "g) Vermoeidheid en sufheid"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Geen"
  option :a3, :value => 2, :description => "3"
  option :a4, :value => 3, :description => "Enige bewustzijnsverlaging"
  option :a5, :value => 4, :description => "Matige tot ernstige bewustzijnsverlaging"
  option :a10, :value => 9, :description => ""
end

question :v_68, :type => :radio do
  title "SCHAAL 6. PROBLEMEN DIE GEPAARD GAAN MET HALLUCINATIES EN/OF WANEN EN/OF CONFABULATIES (OF ONJUISTE OPVATTINGEN)"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Enige vreemde/ excentrieke opvattingenOngevaarlijk maar niet overeenkomstig culturele normen"
  option :a3, :value => 2, :description => "Aanwezig maar weinig lijdensdruk voor zich zelf of anderen"
  option :a4, :value => 3, :description => "Aanmerkelijke preoccupatie met wanen of hallucinaties, veroorzaakt duidelijk aanwezige lijdensdruk voor zelf of anderen"
  option :a5, :value => 4, :description => "Geestestoestand en gedrag ernstig be'invloed door wanen of hallucinatiesHeeft aanzienlijk impact op pati'ent of anderen"
  option :a10, :value => 9, :description => ""
end

question :v_69, :type => :radio do
  title "b) Hallucinaties"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Geen"
  option :a3, :value => 2, :description => "Aanwezig (bijv. stemmen of beelden) maar weinig lijdensdruk"
  option :a4, :value => 3, :description => "Als hierboven"
  option :a5, :value => 4, :description => "Als hierboven"
  option :a10, :value => 9, :description => ""
end

question :v_70, :type => :radio do
  title "c) Denkstoornis / Confabulaties"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Vermindering van associatie- vermogen"
  option :a3, :value => 2, :description => "Lichte denkstoornis"
  option :a4, :value => 3, :description => "Matige denkstoornis"
  option :a5, :value => 4, :description => "Onbegrijpelijk, niet ter zake doende"
  option :a10, :value => 9, :description => ""
end

question :v_76, :type => :radio do
  title "SCHAAL 7. PROBLEMEN MET DEPRESSIEVE SYMPTOMEN"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Somber, of gering, of voorbijgaande stemmings- wisselingen"
  option :a3, :value => 2, :description => "Duidelijke depressie op subjectieve en objectieve maatstaven (bijv. verlies van belangstelling, plezier of zelfwaardering, gebrek aan energie, of schuldgevoel)"
  option :a4, :value => 3, :description => "Aanzienlijke depressieve symptomen (op subjectieve of objectieve gronden)"
  option :a5, :value => 4, :description => "Ernstige depressieve symptomen op subjectieve of objectieve gronden (bijv. Preoccupatie met schuld en waardeloosheid, of teruggetrokken vanwege diepgaand verlies van belangstelling; ernstig verlies van lustbeleving)"
  option :a10, :value => 9, :description => ""
end

question :v_85, :type => :radio do
  title "SCHAAL 8. OVERIGE PSYCHISCHE EN GEDRAGSPROBLEMEN Scoor het ergste klinische probleem dat niet is gescoord op schaal 6-7"
  description ""
  option :a1, :value => 1, :description => "A) Fobie"
  option :a2, :value => 2, :description => "B) Angst en paniek"
  option :a3, :value => 3, :description => "C) Obsessieve-compulsieve stoornis"
  option :a4, :value => 4, :description => "D) Stress en gespannenheid"
  option :a5, :value => 5, :description => "E) Dissociatieve stoornis"
  option :a6, :value => 6, :description => "F) Somatoforme stoornis"
  option :a7, :value => 7, :description => "G) Eetproblemen"
  option :a8, :value => 8, :description => "H) Slaapproblemen"
  option :a9, :value => 9, :description => "I) Seksuele problemen"
  option :a10, :value => 10, :description => "J) Overig, - zoals opgetogenheid, euforische stemming-, problemen die niet elders zijn gespecificeerd"
end

question :v_79, :type => :radio do
  title "a) Ernst van symptomen"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Niet-klinische problemen"
  option :a3, :value => 2, :description => "In lichte mate - pati'ent heeft nog interactie en is niet teruggetrokken"
  option :a4, :value => 3, :description => "Probleem ligt op matig/duidelijk aanwezig niveau (symptomen zijn duidelijker aanwezig)"
  option :a5, :value => 4, :description => "Ernstige symptomen"
  option :a10, :value => 9, :description => ""
end

question :v_80, :type => :radio do
  title "b) Frequentie"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Af en toe"
  option :a3, :value => 2, :description => "Met tussenpozen"
  option :a4, :value => 3, :description => "Vaker"
  option :a5, :value => 4, :description => "Aanhoudende symptomen"
  option :a10, :value => 9, :description => ""
end

question :v_81, :type => :radio do
  title "c) Mate van beheersing"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Goed beheersbaar"
  option :a3, :value => 2, :description => "Pati'ent handhaaft zekere mate van controle"
  option :a4, :value => 3, :description => "Begint controle te verliezen"
  option :a5, :value => 4, :description => "Domineert of heeft ernstige invloed op de meeste activiteiten"
  option :a10, :value => 9, :description => ""
end

question :v_86, :type => :radio do
  title "d) Mate van lijdensdruk(alleen voor zichzelf)"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Waarschijnlijk niet"
  option :a3, :value => 2, :description => "Lijdt niet ondraaglijk"
  option :a4, :value => 3, :description => "Symptomen leveren meer lijdensdruk op"
  option :a5, :value => 4, :description => "Ernstige lijdensdruk"
  option :a10, :value => 9, :description => ""
end

question :v_82, :type => :radio do
  title "SCHAAL 9. PROBLEMEN MET SOCIALE OF ONDERSTEUNENDE RELATIES"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Is misschien eenzelvig maar onafhankelijk en competent in het gezelschap van anderen"
  option :a3, :value => 2, :description => "Bewijs voor duidelijke problemen met het maken / onderhouden van / aanpassen aan ondersteunende relaties (bijv. vanwege dwingend optreden of voortkomend uit moeizame, uitbuitende, mishandelende relaties met verzorgers)"
  option :a4, :value => 3, :description => "Matig maar duidelijk aanwezig niveau van conflict vastgesteld door pati'ent of anderen"
  option :a5, :value => 4, :description => "Ernstige problemen met relaties (bijv. isolement, terugtrekking, conflict of mishandeling)Grote spanningen en stress (bijv. dreigende verbreking van relaties)"
  option :a10, :value => 9, :description => ""
end

question :v_83, :type => :radio do
  title "b) Frequentie"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Tevreden met belangstellings- niveau"
  option :a3, :value => 2, :description => "Met tussenpozen probleem of wisselend probleem met relaties"
  option :a4, :value => 3, :description => "Hardnekkig probleem binnen relatie dat leidt tot zich enigszins terugtrekken"
  option :a5, :value => 4, :description => "Hardnekkig en doorlopend"
  option :a10, :value => 9, :description => ""
end

question :v_84, :type => :radio do
  title "c) Lijdensdruk"
  description ""
  option :a1, :value => 0, :description => "Geen"
  option :a2, :value => 1, :description => "Geen"
  option :a3, :value => 2, :description => "Geen grote lijdensdruk (licht)"
  option :a4, :value => 3, :description => "Lijdensdruk (duidelijk aanwezig)"
  option :a5, :value => 4, :description => "Zeer grote lijdensdruk"
  option :a10, :value => 9, :description => ""
end

question :v_87, :type => :radio do
  title "SCHAAL 10. PROBLEMEN MET ADL-ACTIVITEITEN"
  description ""
  option :a1, :value => 0, :description => "Goed vermogen tot effectief functioneren"
  option :a2, :value => 1, :description => "Enige tekortkomingen maar kan daar effectief mee omgaan (bijv. slordig, lichtelijk gedesorganiseerd)"
  option :a3, :value => 2, :description => "Stimulering kan nodig zijn.Duidelijk aanwezige maar lichte tekort-komingen die het functioneren be'invloeden.Problemen doen zich voor bij huishoudelijke ADL (bijv. problemen met organiseren en klaarmaken van een maaltijd. Problemen met inschatten van financi'en)"
  option :a4, :value => 3, :description => "Duidelijke problemen bij zowel persoonlijke als huishoudelijke ADL. (bijv. heeft enig toezicht nodig bij aankleden en eten, af en toe urine- incontinentie, kan geen maaltijd klaarmaken.)"
  option :a5, :value => 4, :description => "Ernstig onvermogen op bijna alle gebieden van persoonlijke en huishoudelijke ADL (bijv. volledig toezicht nodig bij aankleden en eten, regelmatig incontinent van urine en faeces.)"
  option :a10, :value => 9, :description => ""
end

question :v_90, :type => :radio do
  title "SCHAAL 11. PROBLEMEN MET WOONOMSTANDIGHEDEN"
  description ""
  option :a1, :value => 0, :description => "Zeer goed"
  option :a2, :value => 1, :description => "Redelijk, bijv. rommelig ingericht/ stank/vuil.Geen fundamentele gebreken."
  option :a3, :value => 2, :description => "Enige duidelijk aanwezige problemen met huisvesting of hulpmiddelen en aanpassingen (bijv. gebouw niet goed toegankelijk).Basis- voorzieningen aanwezig."
  option :a4, :value => 3, :description => "Slecht - Afwezigheid van 1 of meer basis- voorzieningen (bijv. slechte kookfaciliteiten of afwezige verwarming)"
  option :a5, :value => 4, :description => "Ernstige problemen. Heel slecht. Dakloos. (bijv. ontoelaatbare woon- omstandigheden, dreiging uit woning te worden gezet)"
  option :a10, :value => 9, :description => ""
end

question :v_91, :type => :radio do
  title "SCHAAL 12. PROBLEMEN WERK EN VRIJETIJDSBESTEDING - KWALITEIT VAN DAGINVULLING"
  description ""
  option :a1, :value => 0, :description => "Zeer goede mogelijkheden beschikbaar/ toegankelijk"
  option :a2, :value => 1, :description => "Activiteiten beschikbaar maar niet op geschikte tijden"
  option :a3, :value => 2, :description => "Beperkt aanbod van mogelijkheden (bijv. onvoldoende steun door verzorgers/ hulpverleners, of beperkte ondersteuning overdag)"
  option :a4, :value => 3, :description => "Tekort aan beschikbare professionele hulpverlening en ondersteuning om vaardigheden te optimaliseren. Weinig kansen om nieuwe vaardigheden te ontwikkelen"
  option :a5, :value => 4, :description => "Totaal gebrek aan adequate mogelijkheden voor activiteiten overdag"
  option :a10, :value => 9, :description => ""
end

question :v_92, :type => :radio do
  title "b) Mate van medewerking van pati'ent"
  description ""
  option :a1, :value => 0, :description => "Volledige medewerking"
  option :a2, :value => 1, :description => "Pati'ent aarzelend of had moeite met gebruikmaken van faciliteiten"
  option :a3, :value => 2, :description => "Pati'ent wil of kan soms geen gebruik maken van faciliteiten"
  option :a4, :value => 3, :description => "Pati'ent wil of kan geen gebruik maken van faciliteiten"
  option :a5, :value => 4, :description => "Pati'ent weigert of kan nooit gebruik maken van faciliteiten"
  option :a10, :value => 9, :description => ""
end

end_panel

