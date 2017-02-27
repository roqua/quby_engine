title 'Subquestion key clash questionnaire'
do_not_check_key_clashes
panel do
  question :v_0, :type => :radio do
    title "A"
    option :a1, description: 'Optie 1' do
      question :v_0_a1, type: :textarea
    end
    option :a2, description: 'Optie 2'
  end
end
