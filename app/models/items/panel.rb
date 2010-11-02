class Items::Panel < Array
  attr_accessor :title
  attr_accessor :items

  def initialize(options = {})
    @questionnaire = options[:questionnaire]
    @title = options[:title]
    @items = options[:items] || []
  end

  def index
    @questionnaire.panels.index(self)
  end

  def next
    this_panel_index = index
    
    if this_panel_index < @questionnaire.panels.size
      return @questionnaire.panels[this_panel_index + 1]
    else
      nil
    end
  end

  def prev
    this_panel_index = index
    
    if this_panel_index > 0
      return @questionnaire.panels[this_panel_index - 1]
    else
      nil
    end
  end

  def validate_answer(answer_hash)
    items.reduce(true) do |mem, item| 
      next mem unless item.answerable?
      mem && item.validate_answer(answer_hash)
    end
  end
end
