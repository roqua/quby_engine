title "Agoraphobic Cognition Questionnaire"

panel do
 title "ACQ - Agoraphobic Cognitions Questionnaire"
 text "Hieronder staan enkele gedachten of ideeën, die door uw hoofd kunnen gaan wanneer u gespannen of angstig bent. Geef aan *hoe vaak elke gedachte voorkomt wanneer u gespannen of angstig bent*. De vragenlijst bestaat uit 14 gedachten of ideeën. Vink bij iedere gedachte of idee het antwoord aan dat het beste aangeeft hoe vaak deze voorkomt:

De gedachte komt *nooit* voor

De gedachte komt *zelden* voor

De gedachte komt *de helft van de tijd* voor

De gedachte komt *vaak* voor

De gedachte komt *voortdurend* voor"

end 

panel do
question :q01, :type => :radio, :required => true do
  title "Ik ga overgeven."
  option :q03a01, :value => 1, :description => "Nooit"
  option :q03a02, :value => 2, :description => "Zelden"
  option :q03a03, :value => 3, :description => "De helft van de tijd"
  option :q03a04, :value => 4, :description => "Vaak"
  option :q03a05, :value => 5, :description => "Voortdurend"
end

question :q02, :type => :radio, :required => true do
  title "Ik ga flauwvallen."
  option :q03a01, :value => 1, :description => "Nooit"
  option :q03a02, :value => 2, :description => "Zelden"
  option :q03a03, :value => 3, :description => "De helft van de tijd"
  option :q03a04, :value => 4, :description => "Vaak"
  option :q03a05, :value => 5, :description => "Voortdurend"
end

question :q03, :type => :radio, :required => true do
  title "Ik heb vast een hersentumor."
  option :q03a01, :value => 0, :description => "Nooit"
  option :q03a02, :value => 0, :description => "Zelden"
  option :q03a03, :value => 0, :description => "De helft van de tijd"
  option :q03a04, :value => 0, :description => "Vaak"
  option :q03a05, :value => 0, :description => "Voortdurend"
end
end

panel do
question :q04, :type => :radio, :required => true do
  title "Ik krijg een hartaanval."
  option :q03a01, :value => 0, :description => "Nooit"
  option :q03a02, :value => 0, :description => "Zelden"
  option :q03a03, :value => 0, :description => "De helft van de tijd"
  option :q03a04, :value => 0, :description => "Vaak"
  option :q03a05, :value => 0, :description => "Voortdurend"
end

question :q05, :type => :radio, :required => true do
  title "Ik ga stikken."
  option :q03a01, :value => 0, :description => "Nooit"
  option :q03a02, :value => 0, :description => "Zelden"
  option :q03a03, :value => 0, :description => "De helft van de tijd"
  option :q03a04, :value => 0, :description => "Vaak"
  option :q03a05, :value => 0, :description => "Voortdurend"
end

question :q06, :type => :radio, :required => true do
  title "Ik ga me gek gedragen."
  option :q03a01, :value => 0, :description => "Nooit"
  option :q03a02, :value => 0, :description => "Zelden"
  option :q03a03, :value => 0, :description => "De helft van de tijd"
  option :q03a04, :value => 0, :description => "Vaak"
  option :q03a05, :value => 0, :description => "Voortdurend"
end
end

panel do

question :q07, :type => :radio, :required => true do
  title "Ik word blind."
  option :q03a01, :value => 0, :description => "Nooit"
  option :q03a02, :value => 0, :description => "Zelden"
  option :q03a03, :value => 0, :description => "De helft van de tijd"
  option :q03a04, :value => 0, :description => "Vaak"
  option :q03a05, :value => 0, :description => "Voortdurend"
end

question :q08, :type => :radio, :required => true do
  title "Ik zal mezelf niet meer in de hand kunnen houden."
  option :q03a01, :value => 0, :description => "Nooit"
  option :q03a02, :value => 0, :description => "Zelden"
  option :q03a03, :value => 0, :description => "De helft van de tijd"
  option :q03a04, :value => 0, :description => "Vaak"
  option :q03a05, :value => 0, :description => "Voortdurend"
end

question :q09, :type => :radio, :required => true do
  title "Ik zal iemand anders iets aandoen."
  option :q03a01, :value => 0, :description => "Nooit"
  option :q03a02, :value => 0, :description => "Zelden"
  option :q03a03, :value => 0, :description => "De helft van de tijd"
  option :q03a04, :value => 0, :description => "Vaak"
  option :q03a05, :value => 0, :description => "Voortdurend"
end
end

panel do

question :q010, :type => :radio, :required => true do
  title "Ik krijg een beroerte."
  option :q03a01, :value => 0, :description => "Nooit"
  option :q03a02, :value => 0, :description => "Zelden"
  option :q03a03, :value => 0, :description => "De helft van de tijd"
  option :q03a04, :value => 0, :description => "Vaak"
  option :q03a05, :value => 0, :description => "Voortdurend"
end

question :q11, :type => :radio, :required => true do
  title "Ik word gek."
  option :q03a01, :value => 0, :description => "Nooit"
  option :q03a02, :value => 0, :description => "Zelden"
  option :q03a03, :value => 0, :description => "De helft van de tijd"
  option :q03a04, :value => 0, :description => "Vaak"
  option :q03a05, :value => 0, :description => "Voortdurend"
end

question :q12, :type => :radio, :required => true do
  title "Ik ga schreeuwen."
  option :q03a01, :value => 0, :description => "Nooit"
  option :q03a02, :value => 0, :description => "Zelden"
  option :q03a03, :value => 0, :description => "De helft van de tijd"
  option :q03a04, :value => 0, :description => "Vaak"
  option :q03a05, :value => 0, :description => "Voortdurend"
end
end

panel do

question :q13, :type => :radio, :required => true do
  title "Ik ga wartaal uitslaan."
  option :q03a01, :value => 0, :description => "Nooit"
  option :q03a02, :value => 0, :description => "Zelden"
  option :q03a03, :value => 0, :description => "De helft van de tijd"
  option :q03a04, :value => 0, :description => "Vaak"
  option :q03a05, :value => 0, :description => "Voortdurend"
end

question :q14, :type => :radio, :required => true do
  title "Ik word verlamd door angst."
  option :q03a01, :value => 0, :description => "Nooit"
  option :q03a02, :value => 0, :description => "Zelden"
  option :q03a03, :value => 0, :description => "De helft van de tijd"
  option :q03a04, :value => 0, :description => "Vaak"
  option :q03a05, :value => 0, :description => "Voortdurend"
end

end