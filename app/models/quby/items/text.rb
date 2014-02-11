module Quby
  class Items::Text < Item
    require 'extensions/maruku_extensions'

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
      @text = Maruku.new(str).to_html
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

    def answerable?
      false
    end

    def validate_answer(answer_hash)
      true
    end

    def ==(other)
      case other.class
      when String
        @text == other
      when Quby::Items::Text
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
