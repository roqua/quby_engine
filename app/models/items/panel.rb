class Items::Panel < Array
  attr_reader :title
  attr_reader :items

  def initialize(options = {})
    @questionnaire = options[:questionnaire]
    @title = options[:title]
    @items = options[:items]
  end

  def next

  end

  def prev

  end
end
