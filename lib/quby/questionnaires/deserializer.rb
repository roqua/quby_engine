module Quby
  module Questionnaires
    module Deserializer
      # This symbolizes various things. Do not run on arbitrary JSON.
      def self.from_json(json)
        # TODO: last_update
        Entities::Questionnaire.new(json.fetch("key")).tap do |questionnaire|
          questionnaire.title = json.fetch("title")
          questionnaire.description = json.fetch("description")
          questionnaire.outcome_description = json.fetch("outcome_description")
          questionnaire.short_description = json.fetch("short_description")
          questionnaire.abortable = json.fetch("abortable")
          questionnaire.allow_hotkeys = json.fetch("allow_hotkeys")
          questionnaire.license = json.fetch("license").try(:to_sym)
          questionnaire.licensor = json.fetch("licensor")
          questionnaire.language = json.fetch("language").try(:to_sym)

          questionnaire.flags = json.fetch("flags").with_indifferent_access.transform_values do |attrs| 
            build_flag(attrs)
          end

          questionnaire.textvars = json.fetch("textvars").with_indifferent_access.transform_values do |attrs|
            build_textvar(attrs)
          end

          questionnaire.lookup_tables = YAML.load(json.fetch("lookup_tables")).transform_values do |attrs|
            Quby::TableBackend::RangeTree.new(levels: attrs[:levels], tree: attrs[:tree])
          end

          questionnaire.score_calculations = json.fetch("score_calculations").with_indifferent_access.transform_values do |attrs|
            build_score_calculation(attrs)
          end

          questionnaire.score_schemas = json.fetch("score_schemas").with_indifferent_access.transform_values do |schema|
            build_score_schema(schema)
          end

          json.fetch("panels").each do |panel_json|
            load_panel(questionnaire, panel_json)
          end

          # roqua domain
          questionnaire.roqua_keys = json.fetch("roqua_keys")
          questionnaire.sbg_key = json.fetch("sbg_key")
          questionnaire.sbg_domains = json.fetch("sbg_domains").map(&:symbolize_keys)
          questionnaire.outcome_regeneration_requested_at = json.fetch("outcome_regeneration_requested_at").try { |str| Time.zone.parse(str) }
          questionnaire.deactivate_answers_requested_at = json.fetch("deactivate_answers_requested_at").try { |str| Time.zone.parse(str) }
          questionnaire.respondent_types = json.fetch("respondent_types").map(&:to_sym)
          questionnaire.tags = json.fetch("tags")

          json.fetch("charts").each do |chart_json|
            questionnaire.add_chart(build_chart(questionnaire, chart_json))
          end

          questionnaire.outcome_tables = json.fetch("outcome_tables").map do |attributes|
            build_outcome_table(questionnaire, attributes)
          end
        end
      end

      def self.load_panel(questionnaire, panel_json)
        panel = Entities::Panel.new(
          questionnaire: questionnaire,
          key: panel_json.fetch("key"),
          title: panel_json.fetch("title"),
          items: []
        )

        panel_json.fetch("items").each do |item_json|
          panel.items << load_item(questionnaire, item_json)
        end

        questionnaire.add_panel(panel)
      end

      def self.load_item(questionnaire, item_json)
        case item_json.fetch("type")
        when "text"
          Entities::Text.new(item_json.fetch("str"), {
            html_content: item_json.fetch("html_content"),
            display_in: item_json.fetch("display_in").map(&:to_sym),
            col_span: item_json.fetch("col_span"),
            row_span: item_json.fetch("row_span"),
            raw_content: item_json.fetch("raw_content"),
            switch_cycle: item_json.fetch("switch_cycle")
          })
        when "question"
          question = build_question(questionnaire, item_json)
          questionnaire.register_question(question)
          question
        end
      end

      def self.build_question(questionnaire, item_json, parent: nil)
        key = item_json.fetch("key").to_sym
        attributes = {
          questionnaire: questionnaire,
          parent: parent,
          type: item_json.fetch("question_type").to_sym,
          title: item_json.fetch("title"),
          context_free_title: item_json.fetch("context_free_title"),
          description: item_json.fetch("description"),
          presentation: item_json.fetch("presentation").to_sym,
          hidden: item_json.fetch("hidden"),
          depends_on: item_json.fetch("depends_on")&.map(&:to_sym),
          default_position: item_json.fetch("default_position"),
          validations: item_json.fetch("validations").map {|attrs| build_question_validation(attrs)},

          # only selectable via options passed in DSL, not via DSL methods
          # many apply only to certain types of questions
          sbg_key: item_json.fetch("sbg_key"),
          allow_duplicate_option_values: item_json.fetch("allow_duplicate_option_values"),
          allow_blank_titles: item_json.fetch("allow_blank_titles"),
          as: item_json.fetch("as")&.to_sym,
          display_modes: item_json.fetch("display_modes")&.map(&:to_sym),
          autocomplete: item_json.fetch("autocomplete"),
          show_values: item_json.fetch("show_values").to_sym,
          deselectable: item_json.fetch("deselectable"),
          disallow_bulk: item_json.fetch("disallow_bulk"),
          score_header: item_json.fetch("score_header").to_sym,
          sets_textvar: item_json.fetch("sets_textvar").try { lstrip("#{questionnaire.key}_") },
          default_invisible: item_json.fetch("default_invisible"),
          question_group: item_json.fetch("question_group"), # sometimes string, sometimes a symbol in the DSL. Just have to hope this works
          group_minimum_answered: item_json.fetch("group_minimum_answered"),
          group_maximum_answered: item_json.fetch("group_maximum_answered"),
          value_tooltip: item_json.fetch("value_tooltip"),

          #  might be able to deduce from tree structure
          parent_option_key: item_json.fetch("parent_option_key")&.to_sym
        }

        case item_json.fetch("question_type")
        when "check_box"
          Entities::Questions::CheckboxQuestion.new(key, attributes.merge(
            check_all_option: item_json.fetch("check_all_option")&.to_sym,
            uncheck_all_option: item_json.fetch("uncheck_all_option")&.to_sym,
            maximum_checked_allowed: item_json.fetch("maximum_checked_allowed"),
            minimum_checked_required: item_json.fetch("minimum_checked_required"),
          )).tap do |question|
            item_json.fetch("options").each do |option_json|
              question.options << build_option(questionnaire, question, option_json)
            end
          end
        when "date"
          Entities::Questions::DateQuestion.new(key, attributes.merge(
            components: item_json.fetch("components").map(&:to_sym),
            required_components: item_json.fetch("components").map(&:to_sym),
            year_key: item_json.fetch("year_key")&.to_sym,
            month_key: item_json.fetch("month_key")&.to_sym,
            day_key: item_json.fetch("day_key")&.to_sym,
            hour_key: item_json.fetch("hour_key")&.to_sym,
            minute_key: item_json.fetch("minute_key")&.to_sym,
          ))
        when "deprecated", "hidden"
          Entities::Questions::DeprecatedQuestion.new(key, attributes).tap do |question|
            item_json.fetch("options").each do |option_json|
              question.options << build_option(questionnaire, question, option_json)
            end
          end
        when "float"
          Entities::Questions::FloatQuestion.new(key, attributes.merge(
            labels: item_json.fetch("labels"),
            unit: item_json.fetch("unit"),
            size: item_json.fetch("size"),
          ))
        when "integer"
          Entities::Questions::IntegerQuestion.new(key, attributes.merge(
            labels: item_json.fetch("labels"),
            unit: item_json.fetch("unit"),
            size: item_json.fetch("size"),
          ))
        when "radio", "scale"
          Entities::Questions::RadioQuestion.new(key, attributes).tap do |question|
            item_json.fetch("options").each do |option_json|
              question.options << build_option(questionnaire, question, option_json)
            end
          end
        when "select"
          Entities::Questions::RadioQuestion.new(key, attributes).tap do |question|
            item_json.fetch("options").each do |option_json|
              question.options << build_option(questionnaire, question, option_json)
            end
          end
        when "string"
          Entities::Questions::StringQuestion.new(key, attributes.merge(
            unit: item_json.fetch("unit"),
            size: item_json.fetch("size"),
          ))
        when "textarea"
          Entities::Questions::TextQuestion.new(key, attributes.merge(
            lines: item_json.fetch("lines"),
          ))
        else
          raise "Unknown question type: #{item_json}"
        end
      end

      def self.build_option(questionnaire, question, option_json)
        option = Entities::QuestionOption.new(option_json.fetch("key")&.to_sym, question,
          value: option_json.fetch("value"),
          description: option_json.fetch("description"),
          context_free_description: option_json.fetch("context_free_description"),
          inner_title: option_json.fetch("inner_title"),
          hides_questions: option_json.fetch("hides_questions").map(&:to_sym),
          shows_questions: option_json.fetch("shows_questions").map(&:to_sym),
          hidden: option_json.fetch("hidden"),
          placeholder: option_json.fetch("placeholder"),
        )

        option_json.fetch("questions").each do |question_json|
          subquestion = build_question(questionnaire, question_json)
          questionnaire.register_question(subquestion)
          option.questions << subquestion
        end

        option
      end

      def self.build_question_validation(attrs)
        base_validation = {
          type: attrs.fetch("type").to_sym,
          explanation: attrs["explanation"] # not always specified for min/max validation
        }

        case attrs.fetch("type")
        when "requires_answer"
          base_validation
        when "answer_group_minimum", "answer_group_maximum"
          base_validation.merge(
            group: attrs.fetch("group"), # TODO: sometimes a symbol, sometimes a string in the original, but I hope it doesn't matter
            value: attrs.fetch("value")
          )
        when "valid_integer", "valid_float"
          base_validation
        when "valid_date"
          base_validation.merge(
            subtype: attrs.fetch("subtype").to_sym
          )
        when "minimum", "maximum"
          base_validation.merge(
            value: attrs.fetch("value"),
            subtype: attrs.fetch("subtype").to_sym,
          )
        when "too_many_checked"
          base_validation.merge(
            uncheck_all_key: attrs.fetch("uncheck_all_key").to_sym
          )
        when "maximum_checked_allowed"
          base_validation.merge(
            maximum_checked_value: attrs.fetch("maximum_checked_value")
          )
        when "regexp"
          base_validation.merge(
            matcher: Regexp.new(attrs.fetch("matcher"))
          )
        when "not_all_checked"
          base_validation.merge(
            check_all_key: attrs.fetch("check_all_key").to_sym
          )
        end
      end

      def self.build_score_calculation(attrs)
        Entities::ScoreCalculation.new(attrs.fetch("key").to_sym,
          label: attrs.fetch("label"),
          sbg_key: attrs.fetch("sbg_key"),
          options: attrs.fetch("options").symbolize_keys,
          sourcecode: attrs.fetch("sourcecode"),
        )
      end

      def self.build_flag(attrs)
        Entities::Flag.new(
          key: attrs.fetch("key").to_sym,
          description_true: attrs.fetch("description_true"),
          description_false: attrs.fetch("description_false"),
          description: attrs.fetch("description"),
          internal: attrs.fetch("internal"),
          trigger_on: attrs.fetch("trigger_on"),
          shows_questions: attrs.fetch("shows_questions").map(&:to_sym),
          hides_questions: attrs.fetch("hides_questions").map(&:to_sym),
          depends_on: attrs.fetch("depends_on"),                              # TODO: emperically determined to be a string in DSL, is that right?
          default_in_interface: attrs.fetch("default_in_interface"),
        )
      end

      def self.build_textvar(attrs)
        Entities::Textvar.new(
          key: attrs.fetch("key").to_sym,
          description: attrs.fetch("description"),
          default: attrs.fetch("default"),
          depends_on_flag: attrs.fetch("depends_on_flag")&.to_sym
        )
      end

      def self.build_chart(questionnaire, chart_json)
        base_args = {
          title: chart_json.fetch("title"),
          plottables: chart_json.fetch("plottables"),
          y_categories: chart_json.fetch("y_categories"),
          y_range_categories: chart_json.fetch("y_range_categories"),
          chart_type: chart_json.fetch("chart_type"),
          y_range: chart_json.fetch("y_range"),
          tick_interval: chart_json.fetch("tick_interval"),
          plotbands: chart_json.fetch("plotbands"),
        }

        case chart_json.fetch("type")
        when "bar_chart"
          Quby::Questionnaires::Entities::Charting::BarChart.new(chart_json.fetch("key").to_sym,
            plotlines: chart_json.fetch("plotlines"),
            **base_args
          )
        when "line_chart"
          Quby::Questionnaires::Entities::Charting::LineChart.new(chart_json.fetch("key").to_sym,
            y_label: chart_json.fetch("y_label"),
            tonality: chart_json.fetch("tonality").to_sym,
            baseline: YAML.load(chart_json.fetch("baseline")),
            clinically_relevant_change: chart_json.fetch("clinically_relevant_change"),
            **base_args
          )
        when "overview_chart"
          Quby::Questionnaires::Entities::Charting::BarChart.new(chart_json.fetch("key").to_sym,
            subscore: chart_json.fetch("subscore").to_sym,
            y_max: chart_json.fetch("y_max"),
            **base_args
          )
        when "radar_chart"
          Quby::Questionnaires::Entities::Charting::BarChart.new(chart_json.fetch("key").to_sym,
            plotlines: chart_json.fetch("plotlines"),
            **base_args
          )
        end
      end

      def self.build_score_schema(attributes)
        Entities::ScoreSchema.new(
          key: attributes.fetch("key").to_sym,
          label: attributes.fetch("label"),
          subscore_schemas: attributes.fetch("subscore_schemas").map do |subschema|
            {
              key: subschema.fetch("key").to_sym,
              label: subschema.fetch("label"),
              export_key: subschema.fetch("export_key").to_sym,
              only_for_export: subschema.fetch("only_for_export")
            }
          end
        )
      end

      def self.build_outcome_table(questionnaire, attributes)
        Entities::OutcomeTable.new(
          questionnaire: questionnaire,
          key: attributes.fetch("key").to_sym,
          score_keys: attributes.fetch("score_keys").map(&:to_sym),
          subscore_keys: attributes.fetch("subscore_keys").map(&:to_sym),
          name: attributes.fetch("name"),
          default_collapsed: attributes.fetch("default_collapsed"),
        )
      end
    end
  end
end