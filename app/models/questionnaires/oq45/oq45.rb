Quby::Questionnaires.define :oq45 do

  questions :type => :radio,
            :options => [0,1,2,3,4] do
    question :q01, "Ik kan goed met anderen overweg."
    question :q02, "Ik word gauw moe."
    question :q03, "Ik ben nergens in geïnteresseerd."
    question :q04, "Ik sta onder stress op het werk/op school."
    question :q05, "Ik geef mezelf overal de schuld van."
    question :q06, "Ik ben geïrriteerd."
  end

end
