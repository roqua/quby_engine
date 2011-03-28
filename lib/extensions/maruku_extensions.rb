require 'maruku'

#Replace {{var_name}} with <span class='text_var' text_var=var_name></span> 
#TODO: add ability to specify default text to use in case text_var is empty

TextVar = /(\{\{)(.+)(\}\})/


class Maruku
  @@text_vars ||= {}
  def self.setTextVar(varname, value)
    @@text_vars[varname] = value.blank? ? nil : value
  end
  def self.getTextVar(varname)
    @@text_vars[varname]
  end
end

MaRuKu::In::Markdown.register_span_extension(
  :chars => 123, #ASCII ordinal of {
  :regexp => TextVar,
  :handler => lambda do |doc, src, con|
    m = src.read_regexp3(TextVar)
    var_name = m.captures.compact[1]
    string = "<span class='text_var' text_var='#{var_name}'>#{Maruku.getTextVar(var_name) || "{{#{var_name}}}" }</span>"
    con.push doc.md_html(string)
    #con.push doc.md_html("<p>raw html</p>")
    true
end)

klass = ActiveSupport::JSON::Encoding::Encoder

klass.module_eval do
  def check_for_circular_references(value)
            if @seen.any? { |object| object.equal?(value) }
              
              raise Exception, "#{value.class.name} object references itself"
            end
            @seen.unshift value
            yield
          ensure
            @seen.shift
  end
end