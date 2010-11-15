class Items::Text < Item
  require 'maruku'

  attr_accessor :text

  def initialize(str)
    @text = Maruku.new(single_newline_br(str)).to_html
  end

  def single_newline_br(text)  
    # in very clear cases, let newlines become <br /> tags
    text.gsub!(/^[\w\<][^\n]*\n+/) do |x|
      x =~ /\n{2}/ ? x : (x.strip!; x << "  \n")
    end
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
