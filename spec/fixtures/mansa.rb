title "MANSA"
short_description "Kwaliteit van Leven"
description ""
outcome_description "De gemiddelde itemscore van de MANSA wordt berekend op basis van 12 items. De ja/nee vragen worden buiten beschouwing gelaten. De normering van de gemiddelde itemscore die u aantreft als u bij 'Schalen' kijkt is als volgt: scores lager of gelijk aan 3 (= 'ontevreden'); scores tussen 3 en kleiner of gelijk aan 5 (= 'matig tevreden'); scores hoger dan 5 (= 'tevreden')"
panel do
  title "Kwaliteit van Leven (MANSA)"
  text "In deze vragenlijst worden vragen gesteld over hoe tevreden u bent met een aantal levensgebieden. Het is de bedoeling dat u één van de zeven rondjes aanklikt. Hoe verder naar rechts, hoe meer tevreden u bent. Hoe verder naar links, hoe meer ontevreden u bent.

Deze vragenlijst bevat 16 vragen.

Klik op &#39;Volgende vraag&#39; om verder te gaan."
end

default_question_options :score_header => :none

panel do
question :v_1, :type => :scale, :presentation => :horizontal, :required => true do
  title "1. Hoe tevreden bent u met uw leven als geheel?"
  description ""
  option :a1, :value => 1, :description => "zeer ontevreden"
  option :a2, :value => 2, :description => "ontevreden"
  option :a3, :value => 3, :description => "een beetje ontevreden"
  option :a4, :value => 4, :description => "gemengd"
  option :a5, :value => 5, :description => "een beetje tevreden"
  option :a6, :value => 6, :description => "tevreden"
  option :a7, :value => 7, :description => "zeer tevreden"
end

question :v_6, :type => :scale, :presentation => :horizontal, :required => true do

  title "2. Hoe tevreden bent u met uw woning?"
  description ""
  option :a1, :value => 1, :description => "zeer ontevreden"
  option :a2, :value => 2, :description => "ontevreden"
  option :a3, :value => 3, :description => "een beetje ontevreden"
  option :a4, :value => 4, :description => "gemengd"
  option :a5, :value => 5, :description => "een beetje tevreden"
  option :a6, :value => 6, :description => "tevreden"
  option :a7, :value => 7, :description => "zeer tevreden"
end

question :v_7, :type => :scale, :presentation => :horizontal, :required => true do

  title "3. Hoe tevreden bent u met uw huisgenoten of als u alleen woont, hoe tevreden bent u met het feit dat u alleen woont?"
  description ""
  option :a1, :value => 1, :description => "zeer ontevreden"
  option :a2, :value => 2, :description => "ontevreden"
  option :a3, :value => 3, :description => "een beetje ontevreden"
  option :a4, :value => 4, :description => "gemengd"
  option :a5, :value => 5, :description => "een beetje tevreden"
  option :a6, :value => 6, :description => "tevreden"
  option :a7, :value => 7, :description => "zeer tevreden"
end
end

panel do
question :v_8, :type => :scale, :presentation => :horizontal, :required => true do
  title "4. Hoe tevreden bent u met uw dagbesteding?"
  description ""
  option :a1, :value => 1, :description => "zeer ontevreden"
  option :a2, :value => 2, :description => "ontevreden"
  option :a3, :value => 3, :description => "een beetje ontevreden"
  option :a4, :value => 4, :description => "gemengd"
  option :a5, :value => 5, :description => "een beetje tevreden"
  option :a6, :value => 6, :description => "tevreden"
  option :a7, :value => 7, :description => "zeer tevreden"
end

question :v_9, :type => :scale, :presentation => :horizontal, :required => true do

  title "5. Hoe tevreden bent u met uw lichamelijke gezondheid?"
  description ""
  option :a1, :value => 1, :description => "zeer ontevreden"
  option :a2, :value => 2, :description => "ontevreden"
  option :a3, :value => 3, :description => "een beetje ontevreden"
  option :a4, :value => 4, :description => "gemengd"
  option :a5, :value => 5, :description => "een beetje tevreden"
  option :a6, :value => 6, :description => "tevreden"
  option :a7, :value => 7, :description => "zeer tevreden"
end

question :v_10, :type => :scale, :presentation => :horizontal, :required => true do

  title "6. Hoe tevreden bent u met uw psychische gezondheid?"
  description ""
  option :a1, :value => 1, :description => "zeer ontevreden"
  option :a2, :value => 2, :description => "ontevreden"
  option :a3, :value => 3, :description => "een beetje ontevreden"
  option :a4, :value => 4, :description => "gemengd"
  option :a5, :value => 5, :description => "een beetje tevreden"
  option :a6, :value => 6, :description => "tevreden"
  option :a7, :value => 7, :description => "zeer tevreden"
end
end

panel do
question :v_11, :type => :radio, :presentation => :horizontal,:score_header => :description, :required => true do
  title "7. Bent u in het afgelopen jaar slachtoffer geweest van geweld?"
  description ""
  option :a1, :value => 1, :description => "Ja"
  option :a2, :value => 2, :description => "Nee"
end

question :v_12, :type => :scale, :presentation => :horizontal, :required => true do

  title "8. Hoe tevreden bent u met uw persoonlijke veiligheid?"
  description ""
  option :a1, :value => 1, :description => "zeer ontevreden"
  option :a2, :value => 2, :description => "ontevreden"
  option :a3, :value => 3, :description => "een beetje ontevreden"
  option :a4, :value => 4, :description => "gemengd"
  option :a5, :value => 5, :description => "een beetje tevreden"
  option :a6, :value => 6, :description => "tevreden"
  option :a7, :value => 7, :description => "zeer tevreden"
end

question :v_13, :type => :radio, :presentation => :horizontal,:score_header => :description, :required => true do
  title "9. Bent u in het afgelopen jaar beschuldigd van een misdrijf?"
  description ""
  option :a1, :value => 1, :description => "Ja"
  option :a2, :value => 2, :description => "Nee"
end
end

end_panel

score :somscore, :label => "Score" do
  somvars = values_with_nils('v_1','v_6','v_7','v_8','v_9','v_10','v_12','v_16','v_17','v_18','v_19','v_20').select{|v| v and v.to_f > 0}
  if somvars.size >= 8
    somscore = ((somvars.map(&:to_i).reduce(&:+) / somvars.size.to_f) * 12).round
    gemm = (somscore / 12.0).round 2
    if gemm <= 3
      interpretation = "Ontevreden"
      oru_flag = "LL"
    elsif gemm <= 5
      interpretation = "Matig tevreden"
      oru_flag = "L"
    else
      interpretation = "Tevreden"
    end
    {
      :label => "Score",
      :value => somscore,
      :mean => gemm,
      :interpretation => interpretation,
      :oru_flag => oru_flag
    }
  else
    {
      :label => "Score"
    }
  end
end

attention do
  variables = ['v_1','v_6','v_7','v_8','v_9','v_10','v_12','v_16','v_17','v_18','v_19','v_20']
  variables.select {|key| [4, 5].include? values[key] }
end

alarm do
  variables = ['v_1','v_6','v_7','v_8','v_9','v_10','v_12','v_16','v_17','v_18','v_19','v_20']
  variables.select {|key| [1, 2, 3].include? values[key] }
end
