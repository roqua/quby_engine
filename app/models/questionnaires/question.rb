module Questionnaires
  class Question
    
    attr_accessor :str
    
    def initialize(str)
      @str = str
    end
    
    def choices
      {
        0 => "helemaal niet mee eens",
        1 => "niet mee eens",
        2 => "onverschillig",
        3 => "mee eens",
        4 => "helemaal mee eens"
      }
    end
    
  end
end
