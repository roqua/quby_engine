# frozen_string_literal: true

# Methods added to this helper will be available to all templates in the application.
module Quby
  module ApplicationHelper
    include Quby::TextTransformation
    include ::Webpacker::Helper

    def current_webpacker_instance
      Quby.webpacker
    end
  end
end
