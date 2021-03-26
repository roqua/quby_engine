# frozen_string_literal: true

require 'active_model'
require 'quby/settings'
require 'quby/questionnaires/entities/flag'
require 'quby/questionnaires/entities/textvar'
require 'quby/questionnaires/entities/validation'
require 'quby/questionnaires/entities/visibility_rule'

require 'action_view'
include ActionView::Helpers::SanitizeHelper

module Quby
  module Questionnaires
    module Entities
      class Questionnaire
        extend  ActiveModel::Naming
        include ActiveModel::Validations

        class ValidationError < StandardError; end
        class UnknownInputKey < ValidationError; end
        class InputKeyAlreadyDefined < ValidationError; end

        VALID_LICENSES = [:unknown,
                          :free,               # freely available without license costs,
                          :pay_per_completion, # costs associated with each completed questionnaire,
                          :private,            # not a publicly available questionnaire
                          :deprecated]         # should no longer be used, hide from view

        RESPONDENT_TYPES = %i( profess patient parent second_parent teacher caregiver )

        def initialize(key, attributes = {}, last_update: Time.now)
          @key = key
          @attributes = attributes
          @sbg_domains = []
          @last_update = Time.at(last_update.to_i)
          @score_calculations = {}.with_indifferent_access
          @charts = Charting::Charts.new
          @fields = Fields.new(self)
          @license = :unknown
          @renderer_version = :v1
          @extra_css = ""
          @allow_switch_to_bulk = false
          @panels = []
          @flags = {}.with_indifferent_access
          @textvars = {}.with_indifferent_access
          @language = :nl
          @respondent_types = []
          @tags = OpenStruct.new
          @check_key_clashes = true
          @validate_html = true
          @score_schemas = {}.with_indifferent_access
          @outcome_tables = []
          @check_score_keys_consistency = true
          @lookup_tables = {}
        end

        attr_reader :attributes

        attr_accessor :key
        attr_accessor :title
        attr_accessor :description
        attr_accessor :outcome_description
        attr_accessor :short_description
        attr_accessor :roqua_keys
        attr_accessor :sbg_key # not required to be unique
        attr_accessor :sbg_domains
        attr_accessor :abortable
        attr_accessor :enable_previous_questionnaire_button
        attr_accessor :panels
        attr_accessor :score_calculations
        attr_accessor :default_answer_value
        attr_accessor :renderer_version
        attr_accessor :leave_page_alert
        attr_reader   :fields
        attr_accessor :extra_css
        attr_accessor :allow_switch_to_bulk
        attr_accessor :license
        attr_accessor :licensor
        attr_accessor :language
        attr_accessor :respondent_types
        attr_reader :tags # tags= is manually defined below
        attr_accessor :outcome_regeneration_requested_at
        attr_accessor :deactivate_answers_requested_at
        # whether to check for clashes between question input keys (HTML form keys)
        attr_accessor :check_key_clashes
        # whether to check consistency of score subkeys during seed generation
        attr_accessor :check_score_keys_consistency
        # If false, we don't check html for validity (for mate1 and mate1_pre)
        attr_accessor :validate_html

        attr_accessor :last_author
        attr_accessor :allow_hotkeys # allow hotkeys for :all views, just :bulk views (default), or :none for never
        attr_accessor :last_update

        attr_accessor :charts

        attr_accessor :flags
        attr_accessor :textvars

        attr_accessor :outcome_tables
        attr_accessor :score_schemas
        attr_accessor :lookup_tables

        delegate :question_hash, :input_keys, :answer_keys, :expand_input_keys, to: :fields

        def tags=(tags)
          tags.each do |tag|
            @tags[tag] = true
          end
        end

        def leave_page_alert
          return nil unless Settings.enable_leave_page_alert
          @leave_page_alert || "Als u de pagina verlaat worden uw antwoorden niet opgeslagen."
        end

        def allow_hotkeys
          (@allow_hotkeys || :bulk).to_s
        end

        def roqua_keys
          @roqua_keys || [key]
        end

        def to_param
          key
        end

        def add_panel(panel)
          @panels << panel
        end

        def register_question(question)
          fields.add(question)

          if question.sets_textvar && !textvars.key?(question.sets_textvar)
            fail "Undefined textvar: #{question.sets_textvar}"
          end
        end

        def validate_questions
          question_hash.each_value do |q|
            unless q.valid?
              q.errors.each { |attr, err| errors.add(attr, err) }
            end
          end
        end

        def questions_tree
          return @questions_tree_cache if @questions_tree_cache

          recurse = lambda do |question|
            [question, question.subquestions.map(&recurse)]
          end

          @questions_tree_cache = (@panels && @panels.map do |panel|
            panel.items.map { |item| recurse.call(item) if item.is_a?(Quby::Questionnaires::Entities::Question) }
          end)
        end

        def questions
          question_hash.values
        end

        def questions_of_type(type)
          questions.select { |question| question.type == type }
        end

        def license=(type)
          fail ArgumentError, 'Invalid license' unless VALID_LICENSES.include?(type)
          @license = type
        end

        def as_json(options = {})
          {
            key: key,
            title: title,
            description: description,
            outcomeDescription: outcome_description,
            shortDescription: short_description,
            panels: panels,
            fields: fields,
            flags: flags,
            textvars: textvars,
            validations: validations,
            visibilityRules: visibility_rules
          }
        end

        # rubocop:disable Metrics/MethodLength
        def to_codebook(options = {})
          output = []
          output << title
          output << "Date unknown"
          output << ""

          options[:extra_vars]&.each do |var|
            output << "#{var[:key]} #{var[:type]}"
            output << "\"#{var[:description]}\""
            output << ""
          end

          top_questions = panels.map do |panel|
            panel.items.select { |item| item.is_a? Question }
          end.flatten.compact

          top_questions.each do |question|
            output << question.to_codebook(self, options)
            output << ""
          end

          flags.each_value do |flag|
            output << flag.to_codebook(options)
            output << ""
          end

          textvars.each_value do |textvar|
            output << textvar.to_codebook(options)
            output << ""
          end

          output = output.join("\n")
          strip_tags(output.gsub(/\<([ 1-9])/, '&lt;\1')).gsub("&lt;", "<")
        end
        # rubocop:enable Metrics/MethodLength

        def key_in_use?(key)
          fields.key_in_use?(key) || score_calculations.key?(key)
        end

        def add_score_calculation(builder)
          if score_calculations.key?(builder.key)
            fail InputKeyAlreadyDefined, "Score key `#{builder.key}` already defined."
          end
          score_calculations[builder.key] = builder
        end

        def add_score_schema(key, label, subschema_options)
          schema = Entities::ScoreSchema.new(key: key, label: label, subscore_schemas: subschema_options)
          schema.valid?
          schema.errors.each do |attribute, message|
            errors.add("Score schema '#{key}'", "#{attribute} #{message}")
          end
          score_schemas[key] = schema
        end

        def scores
          score_calculations.values.select(&:score)
        end

        def find_plottable(key)
          score_calculations[key] || question_hash.with_indifferent_access[key]
        end

        def actions
          score_calculations.values.select(&:action)
        end

        def completion
          score_calculations.values.select(&:completion).first
        end

        def add_chart(chart)
          charts.add chart
        end

        def add_flag(flag_options)
          if flag_options[:internal]
            flag_key = flag_options[:key].to_sym
          else
            flag_key = "#{key}_#{flag_options[:key]}".to_sym
          end
          flag_options[:key] = flag_key
          fail(ArgumentError, "Flag '#{flag_key}' already defined") if flags.key?(flag_key)
          flags[flag_key] = Flag.new(**flag_options)
        end

        def filter_flags(given_flags)
          given_flags.select do |flag_key, _|
            flags.key? flag_key
          end
        end

        def add_textvar(textvar_options)
          textvar_key = "#{key}_#{textvar_options.fetch(:key)}".to_sym
          textvar_options[:key] = textvar_key
          validate_textvar_keys_unique(textvar_key)
          validate_depends_on_flag(textvar_key, textvar_options)
          textvars[textvar_key] = Textvar.new(textvar_options)
        end

        def filter_textvars(given_textvars)
          given_textvars.select do |textvar_key, _|
            textvars.key? textvar_key
          end
        end

        def default_textvars
          textvars.select { |key, textvar| textvar.default.present? }
                  .map    { |key, textvar| [key, textvar.default] }
                  .to_h
        end

        def answer_dsl_module # rubocop:disable Metrics/MethodLength
          # Have to put this in a local variable so the module definition block can access it
          questions_in_var = questions

          @answer_dsl_cache ||= Module.new do
            questions_in_var.each do |question|
              next if question&.key.blank?
              case question.type
              when :date
                question.components.each do |component|
                  # assignment to 'value' hash must be done under string keys
                  key = question.send("#{component}_key").to_s
                  define_method(key) do
                    self.value ||= Hash.new
                    self.value[key]
                  end

                  define_method("#{key}=") do |v|
                    self.value ||= Hash.new
                    self.value[key] = v&.strip
                  end
                end

                define_method(question.key) do
                  self.value ||= Hash.new

                  components = question.components.sort
                  component_values = components.map do |component|
                    value_key = question.send("#{component}_key").to_s
                    self.value[value_key]
                  end
                  case components
                  when [:day, :month, :year]
                    component_values.reverse.take_while { |p| p.present? }.reverse.join('-')
                  when [:month, :year]
                    component_values.reject(&:blank?).join('-')
                  when [:hour, :minute]
                    component_values.all?(&:blank?) ? '' : component_values.join(':')
                  end
                end

              when :check_box

                define_method(question.key) do
                  self.value ||= Hash.new
                  self.value[question.key.to_s] ||= Hash.new
                end

                question.options.each do |opt|
                  next if opt&.key.blank?
                  define_method("#{opt.key}") do
                    self.value ||= Hash.new
                    self.value[question.key.to_s] ||= Hash.new
                    self.value[opt.key.to_s] ||= 0
                  end

                  define_method("#{opt.key}=") do |v|
                    v = v.to_i
                    self.value ||= Hash.new
                    self.value[question.key.to_s] ||= Hash.new
                    self.value[question.key.to_s][opt.key.to_s] = v
                    self.value[opt.key.to_s] = v
                  end
                end
              else
                # Includes:
                # question.type == :radio
                # question.type == :scale
                # question.type == :select
                # question.type == :string
                # question.type == :textarea
                # question.type == :integer
                # question.type == :float

                define_method(question.key) do
                  self.value ||= Hash.new
                  self.value[question.key.to_s]
                end

                define_method(question.key.to_s + "=") do |v|
                  self.value ||= Hash.new
                  self.value[question.key.to_s] = v
                end
              end rescue nil
            end
          end
        end

        def add_outcome_table(outcome_table_options)
          outcome_tables << OutcomeTable.new(**outcome_table_options, questionnaire: self)
        end

        def validations
          @validations ||= fields.question_hash.values.flat_map do |question|
            question.validations.map do |validation|
              case validation[:type]
              when :answer_group_minimum, :answer_group_maximum
                Validation.new(validation.merge(field_keys: questions.select {|q| q.question_group == validation[:group]}.map(&:key)))
              else
                Validation.new(validation.merge(field_key: question.key))
              end
            end
          end.uniq(&:config)
        end

        def visibility_rules
          @visibility_rules ||= fields.question_hash.values.flat_map { |question| VisibilityRule.from(question) } \
                              + flags.values.flat_map { |flag| VisibilityRule.from_flag(flag) }
        end

        private

        def validate_depends_on_flag(textvar_key, textvar_options)
          if textvar_options[:depends_on_flag].present? && !flags.key?(textvar_options[:depends_on_flag])
            fail(ArgumentError,
                 "Textvar '#{textvar_key}' depends on nonexistent flag '#{textvar_options[:depends_on_flag]}'")
          end
        end

        def validate_textvar_keys_unique(textvar_key)
          fail(ArgumentError, "Textvar '#{textvar_key}' already defined") if textvars.key?(textvar_key)
        end
      end
    end
  end
end
