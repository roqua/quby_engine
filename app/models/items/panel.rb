class Items::Panel < Item
  attr_accessor :title
  attr_accessor :items
  attr_accessor :key
  
  def initialize(options = {})
    @questionnaire = options[:questionnaire]
    @title = options[:title]
    @key = options[:key]
    @items = options[:items] || []
  end

  def as_json(options = {})
    super.merge({
      :title => title,
      :items => items
    })
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

  def validations
    vals = {}
    items.each do |item|
      if item.is_a? Items::Question
        item.options.each do |opt|
          if opt.questions
            opt.questions.each do |q|
              vals[q.key] = q.validations
            end
          end
        end
        vals[item.key] = item.validations 
      end
    end
    vals
  end
end
