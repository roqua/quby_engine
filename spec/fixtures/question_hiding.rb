title "QuestHiding"
short_description ""
description ""
outcome_description ""

default_question_options deselectable: true

panel do
  question :v_4, :type => :select do
    title "P00"
    description ""
    option :a0, :value => 0, :description => "--- Selecteer ---", :placeholder => true
    option :a1, :value => 1, :description => "show 2, 4", :shows_questions => [:v_7, :v_9]
    option :a2, :value => 2, :description => "hide 2", :hides_questions => [:v_7]
    option :a3, :value => 3, :description => "licht"
  end
  question :v_5, :type => :check_box do
    title "P0"
    description ""
    option :v_5_a1, :value => 1, :description => "show 2, 4", :shows_questions => [:v_7, :v_9]
    option :v_5_a2, :value => 2, :description => "hide 2", :hides_questions => [:v_7]
    option :v_5_a3, :value => 3, :description => "licht"
  end
  question :v_6, :type => :radio do
    title "P1"
    description ""
    option :a1, :value => 1, :description => "afwezig"
    option :a2, :value => 2, :description => "minimaal"
    option :a3, :value => 3, :description => "licht"
    option :a4, :value => 4, :description => "matig hide 2", :hides_questions => [:v_7]
    option :a5, :value => 5, :description => "matig ernstig hide 2", :hides_questions => [:v_7]
    option :a6, :value => 6, :description => "ernstig hide 3, 4", :hides_questions => [:v_8, :v_9]
    option :a7, :value => 7, :description => "extreem show 3", :shows_questions => [:v_8]
  end
  question :v_7, :type => :radio do
    title "P2"
    description ""
    option :a1, :value => 1, :description => "afwezig"
    option :a2, :value => 2, :description => "minimaal"
    option :a3, :value => 3, :description => "licht"
    option :a4, :value => 4, :description => "matig show 3", :shows_questions => [:v_8]
    option :a5, :value => 5, :description => "matig ernstig show 3, 4", :shows_questions => [:v_8, :v_9]
    option :a6, :value => 6, :description => "ernstig hide 3", :hides_questions => [:v_8]
    option :a7, :value => 7, :description => "extreem show 3", :shows_questions => [:v_8]
  end
end
panel do
  text "This panel and text should disappear in bulk", :display_in => [:paged, :bulk]
  table :columns => 7, :show_option_desc => true do
    question :v_8, :type => :radio do
      title "P3"
      description ""
      option :a1, :value => 1, :description => "afwezig"
      option :a2, :value => 2, :description => "minimaal"
      option :a3, :value => 3, :description => "licht"
      option :a4, :value => 4, :description => "matig"
      option :a5, :value => 5, :description => "matig ernstig"
      option :a6, :value => 6, :description => "ernstig"
      option :a7, :value => 7, :description => "extreem"
    end

    #This question is only visible if it is shown by a checked option that has its key in :shows_questions
    question :v_9, :type => :radio, :default_invisible => true do
      title "P4"
      description ""
      option :a1, :value => 1, :description => "afwezig"
      option :a2, :value => 2, :description => "minimaal"
      option :a3, :value => 3, :description => "licht"
      option :a4, :value => 4, :description => "matig"
      option :a5, :value => 5, :description => "matig ernstig"
      option :a6, :value => 6, :description => "ernstig"
      option :a7, :value => 7, :description => "extreem"
    end
  end
end

end_panel