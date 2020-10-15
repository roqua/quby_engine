# frozen_string_literal: true

require 'quby/compiler/entities'

module Quby
  module Compiler
    module Entities
      class Panel < Item
        attr_accessor :title
        attr_accessor :items
        attr_accessor :key
        attr_reader :questionnaire

        def initialize(options = {})
          @questionnaire = options[:questionnaire]
          @title = options[:title]
          @key = options[:key]
          @items = options[:items] || []
        end

        def as_json(options = {})
          super.merge(title: title, index: index, items: json_items)
        end

        def index
          @questionnaire.panels.index(self)
        end

        def next
          this_panel_index = index

          if this_panel_index < @questionnaire.panels.size
            return @questionnaire.panels[this_panel_index + 1]
          else
            nil
          end
        end

        def prev
          this_panel_index = index

          if this_panel_index > 0
            return @questionnaire.panels[this_panel_index - 1]
          else
            nil
          end
        end

        def json_items
          items.map do |item|
            case item
            when Text
              { type: 'html', html: item.html }
            when Question
              next if item.table # things inside a table are added to the table, AND ALSO to the panel. skip them.
              { type: 'question', key: item.key }
            when Table
              { type: "table" }
            end
          end.compact
        end

        def validations
          vals = {}
          items.each do |item|
            if item.is_a? Question
              item.options.each do |opt|
                if opt.questions
                  opt.questions.each do |q|
                    vals[q.key] = q.validations
                  end
                end
              end
              vals[item.key] = item.validations
            end
          end
          vals
        end
      end
    end
  end
end
