module HighlighterHelper

  def highlight(text)
    Albino.new(text, :ruby)
  end

end
