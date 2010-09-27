class Items::Panel < Array
  attr_accessor :title
  attr_accessor :items

  def initialize(options = {})
    @questionnaire = options[:questionnaire]
    @title = options[:title]
    @items = options[:items] || []
  end

  def next
    this_panel_index = @questionnaire.panels.index(self)
    
    if this_panel_index < @questionnaire.panels.size
      return this_panel_index + 1
    else
      nil
    end
  end

  def prev

  end

  def validate_answer(answer_hash)
    items.collect { |mem, item| mem && item.validate_answer(answer_hash) }
  end
end
