title "QuestHiding"
short_description ""
description ""
outcome_description ""

default_question_options deselectable: true

panel do
  question :v_4, :type => :select do
    title "P00"
    option :a0, :value => 0, :description => "--- Selecteer ---", :placeholder => true
    option :a1, :value => 1, :description => "show 2,4,5,6,7,8",
           :shows_questions => [:v_7, :v_9, :v_10, :v_11, :v_12, :v_13]
    option :a2, :value => 2, :description => "hide 2", :hides_questions => [:v_7]
    option :a3, :value => 3, :description => "licht"
  end
  question :v_5, :type => :check_box do
    title "P0"
    option :v_5_a1, :value => 1, :description => "show 2,4,5,6,7,8",
           :shows_questions => [:v_7, :v_9, :v_10, :v_11, :v_12, :v_13]
    option :v_5_a2, :value => 2, :description => "hide 2", :hides_questions => [:v_7]
    option :v_5_a3, :value => 3, :description => "licht"
  end
  question :v_6, :type => :radio do
    title "P1"
    option :a1, :value => 1, :description => "afwezig"
    option :a2, :value => 2, :description => "minimaal"
    option :a3, :value => 3, :description => "licht"
    option :a4, :value => 4, :description => "matig hide 2", :hides_questions => [:v_7]
    option :a5, :value => 5, :description => "matig ernstig hide 2", :hides_questions => [:v_7]
    option :a6, :value => 6, :description => "ernstig hide 3,4,5,6,7,8",
           :hides_questions => [:v_8, :v_9, :v_10, :v_11, :v_12, :v_13]
    option :a7, :value => 7, :description => "extreem show 3", :shows_questions => [:v_8]
  end
  question :v_7, :type => :radio do
    title "P2"
    option :a1, :value => 1, :description => "afwezig"
    option :a2, :value => 2, :description => "minimaal"
    option :a3, :value => 3, :description => "licht"
    option :a4, :value => 4, :description => "matig show 3", :shows_questions => [:v_8]
    option :a5, :value => 5,
           :description => "matig ernstig show 3,4,5,6,7,8",
           :shows_questions => [:v_8, :v_9, :v_10, :v_11, :v_12, :v_13]
    option :a6, :value => 6, :description => "ernstig hide 3", :hides_questions => [:v_8]
    option :a7, :value => 7, :description => "extreem show 3", :shows_questions => [:v_8] do
      question :v_7sub, type: :string
    end

  end

  table :columns => 1, :show_option_desc => true do
    question :v_10, :type => :date do
      title "P5"
    end

    question :v_11, :type => :string do
      title "P6"
    end

    question :v_12, :type => :integer do
      title "P7"
    end

    question :v_13, :type => :textarea do
      title "P8"
    end
  end
end

panel do
  text "Text", :display_in => [:paged, :bulk]
  table :columns => 7, :show_option_desc => true do
    question :v_8, :type => :radio do
      title "P3"
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