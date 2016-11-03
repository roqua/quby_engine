module Quby
  module TextTransformation
    # Modal pop up window link: ~~url~~link_body~~
    LINK_URL_REGEX = /(\~\~)(.+)(\~\~)(.+)(\~\~)/

    # Textvars: Replace {{var_name}} with <span class='textvar' textvar='var_name'></span>
    TEXT_VAR_REGEX = /(\{\{)(.+?)(\}\})/

    # to eventually replace maruku_extensions.rb
    # this helper transforms ~~ links and text vars into appropriate html
    def transform_special_text(text)
      transformed_links = text.gsub(LINK_URL_REGEX, link_html('\2', '\4'))
      transformed_links.gsub(TEXT_VAR_REGEX, textvar_html('\2'))
    end

    def link_html(url, link_content)
      "<a href='#' onclick='modalFrame(\"#{url}\");'>#{link_content}</a>"
    end

    def textvar_html(var_name)
      "<span class='textvar' textvar='#{var_name}'>{{#{var_name}}}</span>"
    end
  end
end
