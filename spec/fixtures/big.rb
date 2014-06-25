title "PANSS"
short_description "Positieve en Negatieve Syndromen Schaal"
description ""
outcome_description ""

abortable
enable_previous_questionnaire_button
allow_hotkeys :all

css "#content .paged .panel .item.text { margin-bottom: -18px !important; margin-top: 36px !important;}
     #content .paged .panel .item.text p { margin-bottom: 0; }"

default_question_options :score_header => :description, :show_values => true, :deselectable => true

panel do
  title "Positieve en Negatieve Syndromen Schaal (PANSS)"

  text "*Positieve Schaal*"
  table :columns => 7 do
    question :v_6, :type => :radio do
      title "P1 Waanvoorstellingen"
      description ""
      option :a1, :value => 1, :description => "afwezig"
      option :a2, :value => 2, :description => "minimaal"
      option :a3, :value => 3, :description => "licht"
      option :a4, :value => 4, :description => "matig", :hides_questions => [:v_50]
      option :a5, :value => 5, :description => "matig ernstig", :hides_questions => [:v_50]
      option :a6, :value => 6, :description => "ernstig", :hides_questions => [:v_50]
      option :a7, :value => 7, :description => "extreem", :hides_questions => [:v_50]
    end
    question :v_7, :type => :radio do
      title "P2 Conceptuele desorganisatie"
      description ""
      option :a1, :value => 1, :description => "afwezig"
      option :a2, :value => 2, :description => "minimaal"
      option :a3, :value => 3, :description => "licht"
      option :a4, :value => 4, :description => "matig", :hides_questions => [:v_50]
      option :a5, :value => 5, :description => "matig ernstig", :hides_questions => [:v_50]
      option :a6, :value => 6, :description => "ernstig", :hides_questions => [:v_50]
      option :a7, :value => 7, :description => "extreem", :hides_questions => [:v_50]
    end
    question :v_8, :type => :radio do
      title "P3 Hallucinatoir gedrag"
      description ""
      option :a1, :value => 1, :description => "afwezig"
      option :a2, :value => 2, :description => "minimaal"
      option :a3, :value => 3, :description => "licht"
      option :a4, :value => 4, :description => "matig", :hides_questions => [:v_50]
      option :a5, :value => 5, :description => "matig ernstig", :hides_questions => [:v_50]
      option :a6, :value => 6, :description => "ernstig", :hides_questions => [:v_50]
      option :a7, :value => 7, :description => "extreem", :hides_questions => [:v_50]
    end
    question :v_9, :type => :radio do
      title "P4 Opwinding"
      description ""
      option :a1, :value => 1, :description => "afwezig"
      option :a2, :value => 2, :description => "minimaal"
      option :a3, :value => 3, :description => "licht"
      option :a4, :value => 4, :description => "matig"
      option :a5, :value => 5, :description => "matig ernstig"
      option :a6, :value => 6, :description => "ernstig"
      option :a7, :value => 7, :description => "extreem"
    end
    question :v_10, :type => :radio do
      title "P5 Pompeusheid"
      description ""
      option :a1, :value => 1, :description => "afwezig"
      option :a2, :value => 2, :description => "minimaal"
      option :a3, :value => 3, :description => "licht"
      option :a4, :value => 4, :description => "matig"
      option :a5, :value => 5, :description => "matig ernstig"
      option :a6, :value => 6, :description => "ernstig"
      option :a7, :value => 7, :description => "extreem"
    end
    question :v_11, :type => :radio do
      title "P6 Achterdocht/ achtervolgingswaan"
      description ""
      option :a1, :value => 1, :description => "afwezig"
      option :a2, :value => 2, :description => "minimaal"
      option :a3, :value => 3, :description => "licht"
      option :a4, :value => 4, :description => "matig"
      option :a5, :value => 5, :description => "matig ernstig"
      option :a6, :value => 6, :description => "ernstig"
      option :a7, :value => 7, :description => "extreem"
    end
    question :v_12, :type => :radio do
      title "P7 Vijandigheid"
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

  text "*Negatieve Schaal*"
  table :columns => 7 do
    question :v_20, :type => :radio do
      title "N1 Afgestompt gevoel"
      description ""
      option :a1, :value => 1, :description => "afwezig"
      option :a2, :value => 2, :description => "minimaal"
      option :a3, :value => 3, :description => "licht"
      option :a4, :value => 4, :description => "matig", :hides_questions => [:v_50]
      option :a5, :value => 5, :description => "matig ernstig", :hides_questions => [:v_50]
      option :a6, :value => 6, :description => "ernstig", :hides_questions => [:v_50]
      option :a7, :value => 7, :description => "extreem", :hides_questions => [:v_50]
    end
    question :v_21, :type => :radio do
      title "N2 Emotionele teruggetrokkenheid"
      description ""
      option :a1, :value => 1, :description => "afwezig"
      option :a2, :value => 2, :description => "minimaal"
      option :a3, :value => 3, :description => "licht"
      option :a4, :value => 4, :description => "matig"
      option :a5, :value => 5, :description => "matig ernstig"
      option :a6, :value => 6, :description => "ernstig"
      option :a7, :value => 7, :description => "extreem"
    end
    question :v_22, :type => :radio do
      title "N3 Contactgestoordheid"
      description ""
      option :a1, :value => 1, :description => "afwezig"
      option :a2, :value => 2, :description => "minimaal"
      option :a3, :value => 3, :description => "licht"
      option :a4, :value => 4, :description => "matig"
      option :a5, :value => 5, :description => "matig ernstig"
      option :a6, :value => 6, :description => "ernstig"
      option :a7, :value => 7, :description => "extreem"
    end
    question :v_23, :type => :radio do
      title "N4 Passieve/ apathische sociale teruggetrokkenheid"
      description ""
      option :a1, :value => 1, :description => "afwezig"
      option :a2, :value => 2, :description => "minimaal"
      option :a3, :value => 3, :description => "licht"
      option :a4, :value => 4, :description => "matig", :hides_questions => [:v_50]
      option :a5, :value => 5, :description => "matig ernstig", :hides_questions => [:v_50]
      option :a6, :value => 6, :description => "ernstig", :hides_questions => [:v_50]
      option :a7, :value => 7, :description => "extreem", :hides_questions => [:v_50]
    end
    question :v_24, :type => :radio do
      title "N5 Moeilijkheden bij het abstract denken"
      description ""
      option :a1, :value => 1, :description => "afwezig"
      option :a2, :value => 2, :description => "minimaal"
      option :a3, :value => 3, :description => "licht"
      option :a4, :value => 4, :description => "matig"
      option :a5, :value => 5, :description => "matig ernstig"
      option :a6, :value => 6, :description => "ernstig"
      option :a7, :value => 7, :description => "extreem"
    end
    question :v_25, :type => :radio do
      title "N6 Gebrek aan spontaniteit en conversabiliteit"
      description ""
      option :a1, :value => 1, :description => "afwezig"
      option :a2, :value => 2, :description => "minimaal"
      option :a3, :value => 3, :description => "licht"
      option :a4, :value => 4, :description => "matig", :hides_questions => [:v_50]
      option :a5, :value => 5, :description => "matig ernstig", :hides_questions => [:v_50]
      option :a6, :value => 6, :description => "ernstig", :hides_questions => [:v_50]
      option :a7, :value => 7, :description => "extreem", :hides_questions => [:v_50]
    end
    question :v_26, :type => :radio do
      title "N7 Stereotiep denkpatroon"
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
  text "*Algemene Psychopathologie Schaal*"
  table :columns => 7 do
    question :v_34, :type => :radio do
      title "G1 Somatische bezorgdheid"
      description ""
      option :a1, :value => 1, :description => "afwezig"
      option :a2, :value => 2, :description => "minimaal"
      option :a3, :value => 3, :description => "licht"
      option :a4, :value => 4, :description => "matig"
      option :a5, :value => 5, :description => "matig ernstig"
      option :a6, :value => 6, :description => "ernstig"
      option :a7, :value => 7, :description => "extreem"
    end
    question :v_35, :type => :radio do
      title "G2 Angst"
      description ""
      option :a1, :value => 1, :description => "afwezig"
      option :a2, :value => 2, :description => "minimaal"
      option :a3, :value => 3, :description => "licht"
      option :a4, :value => 4, :description => "matig"
      option :a5, :value => 5, :description => "matig ernstig"
      option :a6, :value => 6, :description => "ernstig"
      option :a7, :value => 7, :description => "extreem"
    end
    question :v_36, :type => :radio do
      title "G3 Schuldgevoelens"
      description ""
      option :a1, :value => 1, :description => "afwezig"
      option :a2, :value => 2, :description => "minimaal"
      option :a3, :value => 3, :description => "licht"
      option :a4, :value => 4, :description => "matig"
      option :a5, :value => 5, :description => "matig ernstig"
      option :a6, :value => 6, :description => "ernstig"
      option :a7, :value => 7, :description => "extreem"
    end
    question :v_37, :type => :radio do
      title "G4 Spanning"
      description ""
      option :a1, :value => 1, :description => "afwezig"
      option :a2, :value => 2, :description => "minimaal"
      option :a3, :value => 3, :description => "licht"
      option :a4, :value => 4, :description => "matig"
      option :a5, :value => 5, :description => "matig ernstig"
      option :a6, :value => 6, :description => "ernstig"
      option :a7, :value => 7, :description => "extreem"
    end
    question :v_38, :type => :radio do
      title "G5 Manierisme en poses"
      description ""
      option :a1, :value => 1, :description => "afwezig"
      option :a2, :value => 2, :description => "minimaal"
      option :a3, :value => 3, :description => "licht"
      option :a4, :value => 4, :description => "matig", :hides_questions => [:v_50]
      option :a5, :value => 5, :description => "matig ernstig", :hides_questions => [:v_50]
      option :a6, :value => 6, :description => "ernstig", :hides_questions => [:v_50]
      option :a7, :value => 7, :description => "extreem", :hides_questions => [:v_50]
    end
    question :v_39, :type => :radio do
      title "G6 Depressie"
      description ""
      option :a1, :value => 1, :description => "afwezig"
      option :a2, :value => 2, :description => "minimaal"
      option :a3, :value => 3, :description => "licht"
      option :a4, :value => 4, :description => "matig"
      option :a5, :value => 5, :description => "matig ernstig"
      option :a6, :value => 6, :description => "ernstig"
      option :a7, :value => 7, :description => "extreem"
    end
    question :v_40, :type => :radio do
      title "G7 Motorische retardatie"
      description ""
      option :a1, :value => 1, :description => "afwezig"
      option :a2, :value => 2, :description => "minimaal"
      option :a3, :value => 3, :description => "licht"
      option :a4, :value => 4, :description => "matig"
      option :a5, :value => 5, :description => "matig ernstig"
      option :a6, :value => 6, :description => "ernstig"
      option :a7, :value => 7, :description => "extreem"
    end
    question :v_41, :type => :radio do
      title "G8 Gebrek aan samenwerking"
      description ""
      option :a1, :value => 1, :description => "afwezig"
      option :a2, :value => 2, :description => "minimaal"
      option :a3, :value => 3, :description => "licht"
      option :a4, :value => 4, :description => "matig"
      option :a5, :value => 5, :description => "matig ernstig"
      option :a6, :value => 6, :description => "ernstig"
      option :a7, :value => 7, :description => "extreem"
    end
    question :v_42, :type => :radio do
      title "G9 Ongewone gedachteninhoud"
      description ""
      option :a1, :value => 1, :description => "afwezig"
      option :a2, :value => 2, :description => "minimaal"
      option :a3, :value => 3, :description => "licht"
      option :a4, :value => 4, :description => "matig", :hides_questions => [:v_50]
      option :a5, :value => 5, :description => "matig ernstig", :hides_questions => [:v_50]
      option :a6, :value => 6, :description => "ernstig", :hides_questions => [:v_50]
      option :a7, :value => 7, :description => "extreem", :hides_questions => [:v_50]
    end
    question :v_43, :type => :radio do
      title "G10 Desorientatie"
      description ""
      option :a1, :value => 1, :description => "afwezig"
      option :a2, :value => 2, :description => "minimaal"
      option :a3, :value => 3, :description => "licht"
      option :a4, :value => 4, :description => "matig"
      option :a5, :value => 5, :description => "matig ernstig"
      option :a6, :value => 6, :description => "ernstig"
      option :a7, :value => 7, :description => "extreem"
    end
    question :v_44, :type => :radio do
      title "G11 Zwakke aandacht"
      description ""
      option :a1, :value => 1, :description => "afwezig"
      option :a2, :value => 2, :description => "minimaal"
      option :a3, :value => 3, :description => "licht"
      option :a4, :value => 4, :description => "matig"
      option :a5, :value => 5, :description => "matig ernstig"
      option :a6, :value => 6, :description => "ernstig"
      option :a7, :value => 7, :description => "extreem"
    end
    question :v_45, :type => :radio do
      title "G12 Zwak oordeel en inzicht"
      description ""
      option :a1, :value => 1, :description => "afwezig"
      option :a2, :value => 2, :description => "minimaal"
      option :a3, :value => 3, :description => "licht"
      option :a4, :value => 4, :description => "matig"
      option :a5, :value => 5, :description => "matig ernstig"
      option :a6, :value => 6, :description => "ernstig"
      option :a7, :value => 7, :description => "extreem"
    end
    question :v_46, :type => :radio do
      title "G13 Gestoorde wilskracht"
      description ""
      option :a1, :value => 1, :description => "afwezig"
      option :a2, :value => 2, :description => "minimaal"
      option :a3, :value => 3, :description => "licht"
      option :a4, :value => 4, :description => "matig"
      option :a5, :value => 5, :description => "matig ernstig"
      option :a6, :value => 6, :description => "ernstig"
      option :a7, :value => 7, :description => "extreem"
    end
    question :v_47, :type => :radio do
      title "G14 Zwakke beheersing van impulsen"
      description ""
      option :a1, :value => 1, :description => "afwezig"
      option :a2, :value => 2, :description => "minimaal"
      option :a3, :value => 3, :description => "licht"
      option :a4, :value => 4, :description => "matig"
      option :a5, :value => 5, :description => "matig ernstig"
      option :a6, :value => 6, :description => "ernstig"
      option :a7, :value => 7, :description => "extreem"
    end
    question :v_48, :type => :radio do
      title "G15 Preoccupatie"
      description ""
      option :a1, :value => 1, :description => "afwezig"
      option :a2, :value => 2, :description => "minimaal"
      option :a3, :value => 3, :description => "licht"
      option :a4, :value => 4, :description => "matig"
      option :a5, :value => 5, :description => "matig ernstig"
      option :a6, :value => 6, :description => "ernstig"
      option :a7, :value => 7, :description => "extreem"
    end
    question :v_49, :type => :radio do
      title "G16 Actieve asocialiteit"
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
  question :v_50, :type => :radio, :show_values => false do
    title "De ernst van de symptomen P1, P2, P3, N1, N4, N6, G5 en G9 is &le; 3. Gedurende welke periode is de ernst van deze symptomen al op dit lage niveau?"
    description ""
    option :a1, :value => 1, :description => "&lt; 6 maanden"
    option :a2, :value => 2, :description => "&ge; 6 maanden (in remissie)"
  end
end

score :tot, label: "Totaalscore" do
  {
    value: sum(values(:v_1, :v_2)),
    interpretation: "Niet te best"
  }
end

line_chart :tot do
  range 0..100
  plot :tot
  plot :v_50, label: "Ernst"
end
