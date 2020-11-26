title 'Score test'

question :v_1, type: :integer

score_schema :test, 'Testscore' do
  subscore :value, 'Waarde', export_key: :tes do
    value(:v_1)
  end
  subscore :interpretation, 'Waarde', export_key: :tes_i do
    'Matig'
  end
end

score_schema :test2, 'Testscore 2' do
  subscore :value, 'Waarde', export_key: :tes2 do
    values_with_nils(:v_1).first + 5
  end
  subscore :interpretation, 'Waarde', export_key: :tes2_i do
    'Miniem'
  end
end

completion do
  values_with_nils(:v_1).compact.size / 1.0
end