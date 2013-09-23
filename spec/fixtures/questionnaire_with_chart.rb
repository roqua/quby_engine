panel do
  title 'Questionnaire With Chart'

  question :v_1 do
    title 'Title 1'
  end

  question :v_2 do
    title 'Title 2'
  end

  question :v_3 do
    title 'Title 3'
  end
end

score :total, :label => 'Total' do
  {value: sum(values('v_1', 'v_2', 'v_3')) / 3.0}
end

line_chart :tot do
  range 0..100
  plot :total
  plot :v_1, label: 'Label 1'
  plot :v_2
  plot :v_3
end