module Questionnaires

  def self.define_question(str, options = {})
    @str = str
    @type = options[:type]
 
    case @type
    when :open
      OpenQuestion.new(str, options)
    when :radio
      RadioQuestion.new(str, options)
    end
  end

  class Question
    attr_accessor :str
    attr_accessor :type
    attr_accessor :answer

    def initialize(str, options = {})
      @str = str
      @type = options[:type]
    end
  end

  class OpenQuestion < Question
    
  end

  class RadioQuestion < Question

    def choices
      {
        0 => "helemaal niet mee eens",
        1 => "niet mee eens",
        2 => "onverschillig",
        3 => "mee eens",
        4 => "helemaal mee eens"
      }
    end

    def answer
      choices[@answer]
    end
    
  end
end
