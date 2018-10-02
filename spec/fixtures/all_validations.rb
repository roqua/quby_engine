# frozen_string_literal: true

title "All validations"

default_question_options deselectable: true

panel do
  question :v_deselected, type: :radio, required: true do
    option :a0, value: 0
  end
  question :v_placeholder, type: :select do
    option :a0, value: 0, placeholder: true
  end
  question :v_default_invisible, default_invisible: true, type: :radio do
    option :a0, value: 0
  end
  question :v_hides, type: :radio do
    option :a0, value: 0, hides_questions: [:v_hidden, :v_hidden_and_shown, :v_hidden_type]
  end
  question :v_shows, type: :radio do
    option :a0, value: 0, shows_questions: [:v_hidden_and_shown, :v_shown_and_hidden, :v_default_invisible_shown]
  end
  question :v_hides_2, type: :radio do
    option :a0, value: 0, hides_questions: [:v_shown_and_hidden]
  end
  question :v_hidden, type: :radio do
    option :a0, value: 0
  end
  question :v_hidden_and_shown, type: :radio do
    option :a0, value: 0
  end
  question :v_shown_and_hidden, type: :radio do
    option :a0, value: 0
  end
  question :v_default_invisible_shown, default_invisible: true, type: :radio do
    option :a0, value: 0
  end
  question :v_parent, type: :radio, required: true do
    option :a1, value: 1
    option :a0, value: 0 do
      question :v_child, type: :string
    end
  end
  question :v_parent2, type: :radio, required: true do
    option :a1, value: 1
    option :a0, value: 0 do
      question :v_child2, type: :string
    end
  end

  question :v_check_box, type: :check_box do
    option :v_c1
    option :v_c2
    option :v_c3
  end

  question :v_hidden_type, type: :hidden

  question :v_depend, type: :string
  question :v_depends_on, required: true, depends_on: [:v_depend], type: :radio do
    option :a0, value: 0
  end
  question :v_depends_on2, required: true, depends_on: [:v_depend], type: :radio do
    option :a0, value: 0
  end

  question :v_depended_check, type: :check_box do
    title_question :v_depend_title, type: :string, depends_on: [:v_depended_check_a1], required: true
    option :v_depended_check_a1
    option :v_depended_check_a2
  end

  question :v_depended_check2, type: :check_box do
    title_question :v_depend2_title, type: :string, depends_on: [:v_depended_check2_a1], required: true
    option :v_depended_check2_a1
    option :v_depended_check2_a2
  end

  question :v_invalid_integer, type: :integer
  question :v_valid_integer, type: :integer
  question :v_invalid_float, type: :float
  question :v_valid_float, type: :float
  question :v_valid_date, type: :date
  question :v_invalid_regexp, type: :string do
    validates_format_with /a/
  end
  question :v_valid_regexp, type: :string do
    validates_format_with /a/
  end
  question :v_required, type: :string, required: true
  question :v_valid_required, type: :string, required: true
  question :v_date_range_on_minimum, type: :date do
    validates_in_range Date.new(2017, 1, 2)..Date.new(2017, 3, 4)
  end
  question :v_date_range_under_minimum, type: :date do
    validates_in_range Date.new(2017, 1, 2)..Date.new(2017, 3, 4)
  end
  question :v_date_range_on_maximum, type: :date do
    validates_in_range Date.new(2017, 1, 2)..Date.new(2017, 3, 4)
  end
  question :v_date_range_over_maximum, type: :date do
    validates_in_range Date.new(2017, 1, 2)..Date.new(2017, 3, 4)
  end
  question :v_under_minimum, type: :integer do
    validates_minimum 10
  end
  question :v_over_minimum, type: :integer do
    validates_minimum 10
  end
  question :v_under_maximum, type: :integer do
    validates_maximum 10
  end
  question :v_over_maximum, type: :integer do
    validates_maximum 10
  end
  question :v_too_many_checked, type: :check_box, uncheck_all_option: :v_too_many_checked_a0 do
    option :v_too_many_checked_a0
    option :v_too_many_checked_a1
  end
  question :v_not_too_many_checked, type: :check_box, uncheck_all_option: :v_not_too_many_checked_a0 do
    option :v_not_too_many_checked_a0
    option :v_not_too_many_checked_a1
  end

  question :v_over_maximum_checked_allowed, type: :check_box, maximum_checked_allowed: 1 do
    option :v_over_maximum_checked_allowed_a0
    option :v_over_maximum_checked_allowed_a1
  end

  question :v_under_minimum_checked_required, type: :check_box, minimum_checked_required: 3 do
    option :v_under_minimum_checked_required_a0
    option :v_under_minimum_checked_required_a1
  end

  question :v_all_checked, type: :check_box, check_all_option: :v_all_checked_a0 do
    option :v_all_checked_a0
    option :v_all_checked_a1
  end
  question :v_not_all_checked, type: :check_box, check_all_option: :v_not_all_checked_a0 do
    option :v_not_all_checked_a0
    option :v_not_all_checked_a1
  end

  question :v_answer_group_under_minimum, question_group: :group1, group_minimum_answered: 1,  type: :string
  question :v_answer_group_under_minimum1, question_group: :group1, group_minimum_answered: 1, type: :string
  question :v_answer_group_over_minimum, question_group: :group2, group_minimum_answered: 1, type: :string
  question :v_answer_group_over_minimum1, question_group: :group2, group_minimum_answered: 1, type: :string
  question :v_answer_group_under_maximum, question_group: :group3, group_maximum_answered: 1,  type: :string
  question :v_answer_group_under_maximum1, question_group: :group3, group_maximum_answered: 1, type: :string
  question :v_answer_group_over_maximum, question_group: :group4, group_maximum_answered: 1, type: :string
  question :v_answer_group_over_maximum1, question_group: :group4, group_maximum_answered: 1, type: :string

  table columns: 4 do
    question :v_check_answer_group_under_minimum, question_group: :cgroup1, group_minimum_answered: 3, type: :check_box do
      option :v_check_answer_group_under_minimum_a1
      option :v_check_answer_group_under_minimum_a2
    end
    question :v_check_answer_group_under_minimum1, question_group: :cgroup1, group_minimum_answered: 3, type: :check_box do
      option :v_check_answer_group_under_minimum1_a1
      option :v_check_answer_group_under_minimum1_a2
    end
    question :v_check_answer_group_over_minimum, question_group: :cgroup2, group_minimum_answered: 1, type: :check_box do
      option :v_check_answer_group_over_minimum_a1
      option :v_check_answer_group_over_minimum_a2
    end
    question :v_check_answer_group_over_minimum1, question_group: :cgroup2, group_minimum_answered: 1, type: :check_box do
      option :v_check_answer_group_over_minimum1_a1
      option :v_check_answer_group_over_minimum1_a2
    end
    question :v_check_answer_group_under_maximum, question_group: :cgroup3, group_maximum_answered: 2, type: :check_box do
      option :v_check_answer_group_under_maximum_a1
      option :v_check_answer_group_under_maximum_a2
    end
    question :v_check_answer_group_under_maximum1, question_group: :cgroup3, group_maximum_answered: 2, type: :check_box do
      option :v_check_answer_group_under_maximum1_a1
      option :v_check_answer_group_under_maximum1_a2
    end
    question :v_check_answer_group_over_maximum, question_group: :cgroup4, group_maximum_answered: 1, type: :check_box do
      option :v_check_answer_group_over_maximum_a1
      option :v_check_answer_group_over_maximum_a2
    end
    question :v_check_answer_group_over_maximum1, question_group: :cgroup4, group_maximum_answered: 1, type: :check_box do
      option :v_check_answer_group_over_maximum1_a1
      option :v_check_answer_group_over_maximum1_a2
    end
  end

  question :v_textarea, type: :textarea
end
