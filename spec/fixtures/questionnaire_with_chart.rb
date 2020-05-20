# frozen_string_literal: true

panel do
  title 'Questionnaire With Chart'

  question :v_1, type: :string do
    title 'Title 1'
  end

  question :v_2, type: :string do
    title 'Title 2'
  end

  question :v_3, type: :string do
    title 'Title 3'
  end
end

score :total, :label => 'Total', schema: [{key: :value, export_key: :tot, label: 'Score'}] do
  {value: sum(values('v_1', 'v_2', 'v_3')) / 3.0}
end

overview_chart do
  subscore :value
  y_max 100
end

line_chart :tot do
  range 0..100
  plot :total
  plot :v_1, label: 'Label 1'
  plot :v_2
  plot :v_3
end
