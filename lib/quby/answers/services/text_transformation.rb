module Quby
  module TextTransformation
    # Modal pop up window link: ~~url~~link_body~~
    LINK_URL_REGEX = /\~\~(?<url>.+?)\~\~(?<link_content>.+?)\~\~/

    # Textvars: Replace {{var_name}} with <span class='textvar' textvar='var_name'></span>
    TEXT_VAR_REGEX = /\{\{(?<text_var>.+?)\}\}/

    # to eventually replace maruku_extensions.rb
    # this helper transforms ~~ links and {{text vars}} into html
    def transform_special_text(text)
      text.gsub(LINK_URL_REGEX) { |_match| link_html($~[:url], $~[:link_content]) }
          .gsub(TEXT_VAR_REGEX) { |_match| textvar_html($~[:text_var]) }
    end

    def link_html(url, link_content)
      "<a href='#' onclick='modalFrame(\"#{url}\");'>#{link_content}</a>"
    end

    def textvar_html(var_name)
      "<span class='textvar' textvar='#{var_name}'>{{#{var_name}}}</span>"
    end
  end
end
