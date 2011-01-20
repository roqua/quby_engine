class Questionnaire < ActiveRecord::Base
  has_many :answers

  after_initialize :enhance_by_dsl

  before_validation :ensure_linux_line_ends
  before_save :validate_definition_syntax
  after_save  :write_to_disk

  attr_accessor :title
  attr_accessor :description
  attr_accessor :abortable
  attr_accessor :panels
  attr_accessor :scores
  
  attr_accessor :last_author
  
  #allow hotkeys for either :all or just :bulk views
  attr_accessor :allow_hotkeys
  
  #default_scope :order => "key ASC"
  scope :active, where(:active => true)

  validates_presence_of :key
  validates_uniqueness_of :key
  
  def to_param
    key
  end

  def enhance_by_dsl
    if self.definition
      functions = Function.all.map(&:definition).join("\n\n")
      functions_and_definition = [functions, self.definition].join("\n\n")
      begin
        QuestionnaireDsl.enhance(self, functions_and_definition || "")
      rescue Exception => e
        logger.error "ERROR: failed to load questionnaire #{key}: \n #{e.message} \n #{e.backtrace[0..5].join("\n")}"
      end
    end
  end
  
  def definition
    @definition ||= File.read(Rails.root.join("db", "questionnaires", "#{key}.rb")) rescue nil
  end

  def definition=(value)
    @definition = value.gsub("\r\n", "\n")
  end

  def questions_tree
    recurse = lambda do |question|
      [question, question.subquestions.map(&recurse) ]
    end

    @panels && @panels.map do |panel|
      panel.items.map {|item| recurse.call(item) if Items::Question === item }
    end
  end

  def questions
    tree = questions_tree
    questions_tree.flatten rescue []
  end

  def as_json(options = {})
    attributes.merge({
      :key => self.key,
      :title => self.title, 
      :description => self.description,
      :panels => self.panels
    })
  end

  protected

  def ensure_linux_line_ends
    self.definition = self.definition.gsub("\r\n", "\n")
  end

  def validate_definition_syntax
    q = Questionnaire.new
    begin
      functions = Function.all.map(&:definition).join("\n\n")
      QuestionnaireDsl.enhance(q, [functions, self.definition].join("\n\n"))
    #Some compilation errors are Exceptions (pure syntax errors) and some StandardErrors (NameErrors)
    rescue Exception => e
      errors.add(:definition, "Error")
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

    unless Rails.env.development?
      system "cd #{Rails.root}/db/questionnaires && git config --global user.name \"quby #{Rails.root.parent.basename.to_str}, user: #{@last_author}\" && git add . && git commit -m 'auto-commit from admin' &&  git push"
    end
  end
  
end
