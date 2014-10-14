require 'maruku'

# rubocop:disable LineLength

# Replace {{var_name}} with <span class='textvar' textvar='var_name'></span>
TEXT_VAR = /(\{\{)(.+?)(\}\})/
MaRuKu::In::Markdown.register_span_extension(chars: (RUBY_VERSION >= '1.9' ? '{' : 123), # ASCII ordinal of {
                                             regexp: TEXT_VAR,
                                             handler: lambda do |doc, src, con|
                                                        m = src.read_regexp3(TEXT_VAR)
                                                        var_name = m.captures.compact[1]
                                                        string = "<span class='textvar' textvar='#{var_name}'>{{#{var_name}}}</span>"
                                                        con.push doc.md_html(string)
                                                        # con.push doc.md_html("<p>raw html</p>")
                                                        true
                                                      end)

# Modal pop up window link:
# ~~url~~link_body~~
LINK_URL = /(\~\~)(.+)(\~\~)(.+)(\~\~)/
MaRuKu::In::Markdown.register_span_extension(chars: (RUBY_VERSION >= '1.9' ? '~' : 126), # ASCII ordinal of ~
                                             regexp: LINK_URL,
                                             handler: lambda do |doc, src, con|
                                                        m = src.read_regexp3(LINK_URL)
                                                        url = m.captures.compact[1]
                                                        link_body = m.captures.compact[3]
                                                        string = "<a href='#' onclick='modalFrame(\"#{url}\");'>#{link_body}</a>"
                                                        con.push doc.md_html(string)
                                                        true
                                                      end)
