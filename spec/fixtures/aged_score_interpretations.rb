# frozen_string_literal: true

title "Patient age can be used in scores"

panel do
end

score :tot, label: "Totaalscore",
      schema: [{key: :value, export_key: :tot, label: 'Score'},
               {key: :interpretation, export_key: :tot_i, label: 'Interpretatie'}] do
  tot = 10
  if gender != :unknown && age
    if gender == :male
      if (7..12).include? age
        if tot >= 66
          tot_interpretation = "Risico"
        elsif tot >= 60
          tot_interpretation = "Verhoogd"
        elsif tot >= 19
          tot_interpretation = "Normaal"
        else
          tot_interpretation = "Laag"
        end
      elsif (13..19).include? age
        if tot >= 50
          tot_interpretation = "Risico"
        elsif tot >= 48
          tot_interpretation = "Verhoogd"
        elsif tot >= 13
          tot_interpretation = "Normaal"
        else
          tot_interpretation = "Laag"
        end
      end
    elsif gender == :female
      if (7..12).include? age
        if tot >= 76
          tot_interpretation = "Risico"
        elsif tot >= 70
          tot_interpretation = "Verhoogd"
        elsif tot >= 28
          tot_interpretation = "Normaal"
        else
          tot_interpretation = "Laag"
        end
      elsif (13..19).include? age
        if tot >= 62
          tot_interpretation = "Risico"
        elsif tot >= 60
          tot_interpretation = "Verhoogd"
        elsif tot >= 23
          tot_interpretation = "Normaal"
        else
          tot_interpretation = "Laag"
        end
      end
    end
  end

  {
      value: tot,
      interpretation: tot_interpretation
  }
end
