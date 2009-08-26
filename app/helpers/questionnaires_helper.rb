module QuestionnairesHelper
  
  def render_question(id, question)
    case question.type
    when :open
      render :partial => "open_question",  :locals => { :id => id, :question => question }
    when :radio
      render :partial => "radio_question", :locals => { :id => id, :question => question }
    end
  end

end
