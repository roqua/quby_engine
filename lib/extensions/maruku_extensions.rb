require 'maruku'

#Replace {{var_name}} with <span class='text_var' text_var=var_name></span>
#TODO: add ability to specify default text to use in case text_var is empty
TextVar = /(\{\{)(.+?)(\}\})/
class Maruku
  @@text_vars ||= {}
  def self.setTextVar(varname, value)
    text_vars[varname] = value.blank? ? nil : value
  end
  def self.getTextVar(varname)
    text_vars[varname]
  end

  private

  def self.text_vars
    @@text_vars
  end
end

MaRuKu::In::Markdown.register_span_extension(
  :chars => (RUBY_VERSION >= '1.9' ? '{' : 123), #ASCII ordinal of {
  :regexp => TextVar,
  :handler => lambda do |doc, src, con|
    m = src.read_regexp3(TextVar)
    var_name = m.captures.compact[1]
    string = "<span class='text_var' text_var='#{var_name}'>#{Maruku.getTextVar(var_name) || "{{#{var_name}}}" }</span>"
    con.push doc.md_html(string)
    #con.push doc.md_html("<p>raw html</p>")
    true
end)

#Modal pop up window link:
# ~~url~~link_body~~
LinkUrl = /(\~\~)(.+)(\~\~)(.+)(\~\~)/
MaRuKu::In::Markdown.register_span_extension(
  :chars => (RUBY_VERSION >= '1.9' ? '~' : 126), #ASCII ordinal of ~
  :regexp => LinkUrl,
  :handler => lambda do |doc, src, con|
    m = src.read_regexp3(LinkUrl)
    url = m.captures.compact[1]
    link_body = m.captures.compact[3]
    string = "<a href='#' onclick='modalFrame(\"#{url}\");'>#{link_body}</a>"
    con.push doc.md_html(string)
    true
end)

