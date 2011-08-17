class Item
  attr_accessor :presentation
  attr_accessor :switch_cycle
  
  #Raw content may contain a raw HTML replacement for this item
  attr_accessor :raw_content
  
  def initialize(options={})
    @raw_content = options[:raw_content]
    @switch_cycle = options[:switch_cycle] || false
  end
  
  def answerable?; false; end

  def as_json(options = {})
    {
      :class => self.class.to_s
    }
  end

  def to_codebook
    ""
  end
end
