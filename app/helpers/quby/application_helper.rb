# Methods added to this helper will be available to all templates in the application.
module Quby
  module ApplicationHelper
    def tab_to(name, options, html_options = {})
      if options.is_a?(String)
        href = options
      else
        href = url_for(:controller => options[:controller])
      end

      highlight = highlight_active_tab_if_current(href)
      link_to name, options, html_options.reverse_merge(highlight)
    end

    def highlight_active_tab_if_current(url)
      #FIXME: does not highlight the proper tab for the root url
      if request.url.index(url)
        {:id => "current"}
      else
        {}
      end
    end
  end
end
