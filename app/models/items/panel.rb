class Items::Panel < Array
  attr_reader :title
  attr_reader :items

  def initialize(options = {})
    @questionnaire = options[:questionnaire]
    @title = options[:title]
    @items = options[:items]
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
end
