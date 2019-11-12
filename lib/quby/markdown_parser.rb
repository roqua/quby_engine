# frozen_string_literal: true

require 'quby/answers/services/text_transformation'
require 'redcarpet'

module Quby
  class MarkdownParser
    include Quby::TextTransformation

    EXTENTIONS = {
      no_intra_emphasis: true
    }.freeze

    def initialize(source)
      @source = source || ""
    end

    def to_html
      rc_html = parser.render(@source).strip
      transform_special_text(rc_html)
    end

    def html_safe
      to_html.html_safe
    end

    private

    def parser
      @@parser ||= Redcarpet::Markdown.new(HTMLWithPants.new, EXTENTIONS)
    end
  end

  class HTMLWithPants < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants
  end
end
