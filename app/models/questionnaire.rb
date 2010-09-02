class Questionnaire < ActiveRecord::Base
  has_many :answers

  after_initialize :enhance_by_dsl

  before_save :validate_definition_syntax
  after_save  :write_to_disk

  attr_accessor :title
  attr_accessor :description
  attr_accessor :panels
  attr_accessor :scores

  #default_scope :order => "key ASC"
  scope :active, where(:active => true)

  validates_presence_of :key
  validates_uniqueness_of :key

  def enhance_by_dsl
    if self.definition
      functions = Function.all.map(&:definition).join("\n\n")
      functions_and_definition = [functions, self.definition].join("\n\n")
      QuestionnaireDsl.enhance(self, functions_and_definition || "")
    end
  end
  
  def definition
    @definition ||= File.read(Rails.root.join("db", "questionnaires", "#{key}.rb")) rescue nil
  end

  def definition=(value)
    @definition = value
  end

  def questions_tree
    recurse = lambda do |question|
      [question, question.subquestions.map(&recurse) ]
    end

    @panels && @panels.map do |panel|
      panel.items.map do |item| 
        if Question === item
          recurse.call(item)
        end
      end
    end
  end

  def questions
    tree = questions_tree
    questions_tree.flatten rescue []
  end

  def as_json(options = {})
    super(:only => [:key, :title, :description],
          :methods => [:questions])
  end

  protected

  def validate_definition_syntax
    q = Questionnaire.new
    begin
      functions = Function.all.map(&:definition).join("\n\n")
      QuestionnaireDsl.enhance(q, [functions, self.definition].join("\n\n"))
    rescue => e
      errors.add(:definition, "Syntax error")
      errors.add(:definition, e.message)
      errors.add(:definition, e.backtrace[0..5].join("<br/>"))
      return false
    end
    return true
  end

  def write_to_disk
    filename = Rails.root.join("db", "questionnaires", "#{key}.rb")
    logger.info "Writing #{filename}..."
    File.open(filename, "w") {|f| f.write( self.definition ) }
  end
  
end
