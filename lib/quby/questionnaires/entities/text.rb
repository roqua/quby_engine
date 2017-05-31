require 'quby/questionnaires/entities/item'
require 'quby/extensions/maruku_extensions'
require 'kramdown'

module Quby
  module Questionnaires
    module Entities
      class Text < Item
        attr_reader :str
        attr_accessor :text
        attr_accessor :display_in

        # In case of being displayed inside a table, amount of columns/rows to span
        attr_accessor :col_span
        attr_accessor :row_span

        def initialize(str, options = {})
          if options[:html_content]
            options[:raw_content] = "<div class='item text'>" + options[:html_content] + "</div>"
          end
          super(options)
          @str = str
          @text = Kramdown::Document.new(str).to_html
          @display_in = options[:display_in] || [:paged]
          @col_span = options[:col_span] || 1
          @row_span = options[:row_span] || 1
        end

        def as_json(options = {})
          super().merge(text: text)
        end

        def key
          't0'
        end

        def type
          "text"
        end

        def validate_answer(answer_hash)
          true
        end

        def ==(other)
          case other.class
          when String
            @text == other
          when self.class
            @text == other.text
          else
            false
          end
        end

        def to_s
          @text
        end
      end
    end
  end
end
