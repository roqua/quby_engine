title 'SimpleQuestionnaire'
language :en

panel do
  title 'A simple questionnaire'

  question :v_1, type: :radio do
    title 'A simple question'
    description 'A simple instruction'
    option :a1, value: 0, description: 'Simple option 1'
    option :a2, value: 1, description: 'Simple option 2'
    option :a3, value: 2, description: 'Simple option 3'
    option :a4, value: 3, description: 'Simple option 4'
    option :a5, value: 4, description: 'Simple option 5'
  end
end
