module AnswersHelper
  def render_question(id, question)
#    case question.type
#    when :open
#      render :partial => "open_question",  :locals => { :id => id, :question => question }
#    when :radio
      render :partial => "radio_question", :locals => { :id => id, :question => question }
#    end
  end

  def get_validation_json(validations)
    result = {}
    validations.each_pair do |qkey, valar|
      result[qkey] = valar.map do |val|
        if val[:type] == :regexp
          valc = val.clone
          valc[:matcher] = "/#{valc[:matcher].source.to_s}/"
          #Replace single backslashes with two backslashes 
          valc[:matcher].gsub!("\\","\\\\")
          valc
        else
          val
        end
      end 
    end
    result.to_json
  end
  
  #1: splits the question number off into a .qnumber when encountering things like (leading space optional):
  # 1
  # 1.
  # 1a.
  #2: lops off enclosing p tags
  #3: adds .main and %label(for=labelfor) around content
  QUESTION_ID_REGEX = /\A\s*(\d+.?\.|\A\w\)|\A\w\.)(.*)/
  def marukufix(string, labelfor, title_insert=nil)
    return '' unless string
    string.gsub!(/\A\d+.?\./, '  \\0')
    
    if labelfor
      string = Maruku.new(string).to_html.gsub('<p>', '').gsub('</p>','')
      if QUESTION_ID_REGEX.match(string)
        string.gsub!(QUESTION_ID_REGEX, "<div class='main'> <div class='qnumber'>\\1</div> <div class='mainlabelwrap'><label for='#{labelfor}'>\\2</label>#{title_insert}</div></div>")
      else
        string = " <div class='main'><label for='#{labelfor}'>#{string}</label> #{title_insert}</div>"
      end
      raw string
    else
      raw Maruku.new(string).to_html.gsub('<p>', '').gsub('</p>','')
    end
  end
  
  def table_marukufix(string, labelfor, rowspan, title_insert=nil)
    return '' unless string
    string = Maruku.new(string).to_html.gsub('<p>', '').gsub('</p>','')
    if QUESTION_ID_REGEX.match(string)
      string.gsub!(QUESTION_ID_REGEX, "<td class='main' rowspan='#{rowspan}'> <div class='qnumber'>\\1</div> <div class='mainlabelwrap'><label for='#{labelfor}'>\\2</label></div>#{title_insert}</td>")
    else
      string = " <td class='main'><label for='#{labelfor}'>#{string}</label>#{title_insert}</td>"
    end
    raw string
  end
  
  def different_header(item, previous_item)
    return true if (item.score_header != previous_item.andand.score_header or (not previous_item.respond_to?(:options)))
    case item.score_header
    when :question_description
      return item.description != previous_item.description
    when :value
      return previous_item.options.map(&:value) != item.options.map(&:value)
    when :description
      return previous_item.options.map(&:description) != item.options.map(&:description)
    end
  end
  
  def get_question(table, rowi,j)
    table.questions[rowi][j]
  end
  
end
