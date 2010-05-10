class Questionnaire < ActiveRecord::Base
  has_many :answers

  before_save :validate_definition_syntax
  after_save  :write_to_disk

  has_paper_trail

  attr_accessor :title
  attr_accessor :description
  attr_accessor :panels
  attr_accessor :scores

  default_scope :order => "key ASC"
  named_scope :active, :conditions => {:active => true}, :order => 'key ASC'

  validates_uniqueness_of :key

  def after_initialize
    functions = Function.all.map(&:definition).join("\n\n")
    functions_and_definition = [functions, self.definition].join("\n\n")
    QuestionnaireDsl.enhance(self, functions_and_definition || "")
  end
  
  def definition
    if not @definition_on_disk
      begin
        @definition_on_disk ||= File.read(Dir[File.join(RAILS_ROOT, "app", "questionnaires", "#{id}_*.rb")].first)
        write_attribute(:definition, @definition_on_disk)
      rescue
        "" #read_attribute(:definition)
      end
    else
      read_attribute(:definition)
    end
  end
  
  def questions
    @panels.map do |panel|
      panel[:items].select {|item| Question === item }
    end.flatten
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
    filename = File.join(RAILS_ROOT, "app", "questionnaires", "#{id}_#{key}.rb")
    logger.info "Writing #{filename}..."
    File.open(filename, "w") {|f| f.write( read_attribute(:definition) ) }
  end
  
end
