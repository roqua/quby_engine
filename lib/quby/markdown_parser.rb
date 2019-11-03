# frozen_string_literal: true

require 'quby/answers/services/text_transformation'
require 'redcarpet'

module Quby
  class MarkdownParser
    include Quby::TextTransformation

    def initialize(source, questionnaire)
      @questionnaire = questionnaire
      @source = source || ""
    end

    def to_html
      if @questionnaire.check_markdown_validity # checked on save
        parsed_markdown.to_xhtml
      else
        nokogiri_fragment.to_xhtml
      end
    end

    def html_safe
      to_html.html_safe
    end

    def nokogiri_fragment
      Nokogiri::HTML.fragment(parsed_markdown)
    end

    private

    def parsed_markdown
      rc_html = parser.render(@source).strip
      transform_special_text(rc_html)
    end

    def parser
      @@parser ||= Redcarpet::Markdown.new(HTMLWithPants.new)
    end
  end

  class HTMLWithPants < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants
  end
end
