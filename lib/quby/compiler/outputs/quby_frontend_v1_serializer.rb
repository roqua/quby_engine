require 'method_source'

module Quby
  module Compiler
    module Outputs
      class QubyFrontendV1Serializer
        attr_reader :questionnaire

        def initialize(questionnaire)
          @questionnaire = questionnaire
        end

        def panels
          questionnaire.panels.map do |panel|
            {
              key: panel.key,
              title: panel.title,
              items: panel.items.reject { |item| item.respond_to?(:table) && item.table }.map { |item| item_as_json(item) }
            }
          end
        end

        def item_as_json(item)
          case item
          when Quby::Compiler::Entities::Text
            {
              type: 'text',
              str: item.str,
              html_content: item.html_content,
              display_in: item.display_in,
              col_span: item.col_span,
              row_span: item.row_span,
            }
          when Quby::Compiler::Entities::Question
            question_as_json(item)
          when Quby::Compiler::Entities::Table
            table_as_json(item)
          end.merge(raw_content: item.raw_content, switch_cycle: item.switch_cycle)
        end

        def table_as_json(table)
          {
            type: 'table',
            columns: table.columns,
            title: table.title,
            description: table.description,
            show_option_desc: table.show_option_desc,
            items: table.items.map { |item| item_as_json(item) }
          }
        end

        def question_as_json(question)
          base_options = {
            type: 'question',
            question_type: question.type,
            key: question.key,
            title: question.title,
            context_free_title: question.context_free_title,
            description: question.description,
            presentation: question.presentation,
            hidden: question.hidden,
            depends_on: question.depends_on,
            default_position: question.default_position,
            validations: question.validations.map {|validation| validation_as_json(validation) },

            sbg_key: question.sbg_key,
            allow_duplicate_option_values: question.allow_duplicate_option_values,
            allow_blank_titles: question.allow_blank_titles,
            as: question.as,
            display_modes: question.display_modes,
            autocomplete: question.autocomplete,
            show_values: question.show_values,
            deselectable: question.deselectable,
            disallow_bulk: question.disallow_bulk,
            score_header: question.score_header,
            sets_textvar: question.sets_textvar.try { lstrip("#{question.questionnaire.key}_") },
            default_invisible: question.default_invisible,
            question_group: question.question_group,
            group_minimum_answered: question.group_minimum_answered,
            group_maximum_answered: question.group_maximum_answered,
            value_tooltip: question.input_data[:value_tooltip],

            parent_option_key: question.parent_option_key,
          }

          case question
          when Quby::Compiler::Entities::Questions::CheckboxQuestion
            base_options.merge(
              options: question.options.map { |option| option_as_json(option) },
              check_all_option: question.check_all_option,
              uncheck_all_option: question.uncheck_all_option,
              maximum_checked_allowed: question.maximum_checked_allowed,
              minimum_checked_required: question.minimum_checked_required
            )
          when Quby::Compiler::Entities::Questions::DateQuestion
            base_options.merge(
              components: question.components,
              required_components: question.required_components,
              year_key: question.year_key,
              month_key: question.month_key,
              day_key: question.day_key,
              hour_key: question.hour_key,
              minute_key: question.minute_key,
            )
          when Quby::Compiler::Entities::Questions::DeprecatedQuestion
            base_options.merge(
              options: question.options.map { |option| option_as_json(option) }
            )
          when Quby::Compiler::Entities::Questions::FloatQuestion
            base_options.merge(
              labels: question.labels,
              unit: question.unit,
              size: question.size,
            )
          when Quby::Compiler::Entities::Questions::IntegerQuestion
            base_options.merge(
              labels: question.labels,
              unit: question.unit,
              size: question.size,
            )
          when Quby::Compiler::Entities::Questions::RadioQuestion
            base_options.merge(
              options: question.options.map { |option| option_as_json(option) }
            )
          when Quby::Compiler::Entities::Questions::SelectQuestion
            base_options.merge(
              options: question.options.map { |option| option_as_json(option) }
            )
          when Quby::Compiler::Entities::Questions::StringQuestion
            base_options.merge(
              unit: question.unit,
              size: question.size,
            )
          when Quby::Compiler::Entities::Questions::TextQuestion
            base_options.merge(
              lines: question.lines
            )
          else
            raise "Unknown item type"
          end
        end

        def validation_as_json(validation)
          case validation[:type]
          when :requires_answer
            validation.slice(:type, :explanation)
          when :answer_group_minimum, :answer_group_maximum
            validation.slice(:type, :explanation, :group, :value)
          when :valid_integer, :valid_float
            validation.slice(:type, :explanation)
          when :valid_date
            validation.slice(:type, :explanation, :subtype).merge(value_type: validation[:value].class.to_s)
          when :minimum, :maximum
            validation.slice(:type, :explanation, :value, :subtype).merge(value_type: validation[:value].class.to_s)
          when :too_many_checked
            validation.slice(:type, :explanation, :uncheck_all_key)
          when :minimum_checked_required
            validation.slice(:type, :explanation, :minimum_checked_value)
          when :maximum_checked_allowed
            validation.slice(:type, :explanation, :maximum_checked_value)
          when :regexp
            validation.slice(:type, :explanation, :matcher)
          when :not_all_checked
            validation.slice(:type, :explanation, :check_all_key)
          else
            raise "Unknown validation type: #{validation.inspect}"
          end
        end

        def option_as_json(option)
          {
            key: option.key,
            value: option.value,
            description: option.description,
            context_free_description: option.context_free_description,
            questions: option.questions.map {|question| question_as_json(question)},
            inner_title: option.inner_title,
            hides_questions: option.hides_questions,
            shows_questions: option.shows_questions,
            hidden: option.hidden,
            placeholder: option.placeholder,
          }
        end

        def score_calculations
          questionnaire.score_calculations.transform_values do |score_calculation|
            {
              key: score_calculation.key,
              label: score_calculation.label,
              sbg_key: score_calculation.sbg_key,
              options: score_calculation.options,
              sourcecode: score_calculation.calculation&.to_proc&.source
            }

          end
        end

        def score_schemas
          questionnaire.score_schemas.transform_values do |schema|
            {
              key: schema.key,
              label: schema.label,
              subscore_schemas: schema.subscore_schemas.map do |subschema|
                {
                  key: subschema.key,
                  label: subschema.label,
                  export_key: subschema.export_key,
                  only_for_export: subschema.only_for_export
                }
              end
            }
          end
        end

        def charts
          {
            overview: questionnaire.charts.overview && {
              subscore: questionnaire.charts.overview.subscore,
              y_max: questionnaire.charts.overview.y_max,
            },
            others: questionnaire.charts.map do |chart|
              case chart
              when Quby::Compiler::Entities::Charting::BarChart
                {
                  plotlines: chart.plotlines.map do |plotline|
                    {
                      value: plotline[:value],
                      color: plotline[:color],
                      width: plotline[:width],
                      zIndex: plotline[:zIndex]
                    }
                  end
                }
              when Quby::Compiler::Entities::Charting::LineChart
                {
                  y_label: chart.y_label,
                  tonality: chart.tonality,
                  baseline: "TODO", # can be Ruby block of code
                  clinically_relevant_change: chart.clinically_relevant_change,
                }
              when Quby::Compiler::Entities::Charting::OverviewChart
                {
                  subscore: chart.subscore,
                  y_max: chart.y_max,
                }
              when Quby::Compiler::Entities::Charting::RadarChart
                {
                  plotlines: chart.plotlines.map do |plotline|
                    {
                      value: plotline[:value],
                      color: plotline[:color],
                      width: plotline[:width],
                      zIndex: plotline[:zIndex]
                    }
                  end
                }
              end.merge(
                key: chart.key,
                type: chart.type,
                title: chart.title,
                plottables: chart.plottables,
                y_categories: chart.y_categories,
                y_range_categories: chart.y_range_categories,
                chart_type: chart.chart_type,
                y_range: chart.y_range,
                tick_interval: chart.tick_interval,
                plotbands: chart.plotbands
              )
            end
          }
        end

        def flags
          questionnaire.flags.transform_values do |flag|
            {
              key: flag.key,
              description_true: flag.description_true,
              description_false: flag.description_false,
              description: flag.description,
              internal: flag.internal,
              trigger_on: flag.trigger_on,
              shows_questions: flag.shows_questions,
              hides_questions: flag.hides_questions,
              depends_on: flag.depends_on,
              default_in_interface: flag.default_in_interface,
            }
          end
        end

        def textvars
          questionnaire.textvars.transform_values do |textvar|
            {
              key: textvar.key,
              description: textvar.description,
              default: textvar.default,
              depends_on_flag: textvar.depends_on_flag,
            }
          end
        end

        def lookup_tables
          # TODO: Figure out something better. For now, no interest in walking a tree and converting Range objects to something JSON-able.
          YAML.dump(questionnaire.lookup_tables)
        end

        def outcome_tables
          # TODO DOes not seem to be used in definitions?
          questionnaire.outcome_tables.map do |outcome_table|
            {
              key: outcome_table.key,
              score_keys: outcome_table.score_keys,
              subscore_keys: outcome_table.subscore_keys,
              name: outcome_table.name,
              default_collapsed: outcome_table.default_collapsed,
            }
          end
        end

        def as_json(options = {})
          {
            key: questionnaire.key,
            title: questionnaire.title,
            description: questionnaire.description,
            outcome_description: questionnaire.outcome_description,
            short_description: questionnaire.short_description,
            abortable: questionnaire.abortable,
            enable_previous_questionnaire_button: questionnaire.enable_previous_questionnaire_button,
            default_answer_value: questionnaire.default_answer_value,
            leave_page_alert: questionnaire.leave_page_alert,
            allow_hotkeys: questionnaire.allow_hotkeys,
            license: questionnaire.license,
            licensor: questionnaire.licensor,
            language: questionnaire.language,
            renderer_version: questionnaire.renderer_version,
            last_update: questionnaire.last_update,
            last_author: questionnaire.last_author,
            extra_css: questionnaire.extra_css,
            allow_switch_to_bulk: questionnaire.allow_switch_to_bulk,

            panels: panels,
            score_calculations: score_calculations,
            score_schemas: score_schemas,
            flags: flags,
            textvars: textvars,
            lookup_tables: lookup_tables,

            # belong to roqua domain, but for now they're here too:
            roqua_keys: questionnaire.roqua_keys,
            sbg_key: questionnaire.sbg_key,
            sbg_domains: questionnaire.sbg_domains,
            outcome_regeneration_requested_at: questionnaire.outcome_regeneration_requested_at,
            deactivate_answers_requested_at: questionnaire.deactivate_answers_requested_at,
            respondent_types: questionnaire.respondent_types,
            tags: questionnaire.tags.to_h.keys,
            charts: charts,
            outcome_tables: outcome_tables,
          }
        end
      end
    end
  end
end