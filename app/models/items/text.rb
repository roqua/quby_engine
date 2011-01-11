class Items::Text < Item
  require 'maruku'

  attr_accessor :text

  def initialize(str, pure_html = false)
    unless pure_html
      @text = Maruku.new(str).to_html
    else
      @text = str
    end
  end

  def as_json(options = {})
    super().merge({ 
      :text => text
    })
  end

  def key; 't0'; end
  
  def type 
    "text"  
  end
  
  def answerable?
    false
  end

  def validate_answer(answer_hash)
    true
  end

  def ==(other)
    case other.class
    when String
      @text == other
    when Items::Text
      @text == other.text
    else
      false
    end
  end

  def to_s
    @text
  end

end
