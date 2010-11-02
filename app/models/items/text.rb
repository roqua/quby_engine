class Items::Text < Item

  attr_accessor :text

  def initialize(str)
    @text = str
  end

  def key; 't0'; end

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
