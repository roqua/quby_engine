title 'Score test'

question :v_1, type: :integer

score :test, label: 'Testscore',
      schema: [{key: :value, export_key: :tes, label: 'Waarde'},
               {key: :interpretation, export_key: :tes_i, label: 'Interpretatie'}] do
  {value: value(:v_1),
   interpretation: 'Matig'}
end

score :test2, label: 'Testscore 2',
      schema: [{key: :value, export_key: :tes2, label: 'Waarde'},
               {key: :interpretation, export_key: :tes2_i, label: 'Interpretatie'}] do
  {value: values_with_nils(:v_1).first + 5,
   interpretation: 'Miniem'}
end

completion do
   values_with_nils(:v_1).compact.size / 1.0
end