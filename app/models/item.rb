class Item
  attr_accessor :presentation
  
  #Raw content may contain a raw HTML replacement for this item
  attr_accessor :raw_content
  
  def initialize(options={})
    @raw_content = options[:raw_content]    
  end
  
  def answerable?; false; end

  def as_json(options = {})
    {
      :class => self.class.to_s
    }
  end

  def to_codebook(questionnaire, options = {})
    ""
  end
end
