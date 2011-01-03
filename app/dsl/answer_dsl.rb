module AnswerDsl
  def self.enhance(target_instance)
    answer = target_instance
    questionnaire = target_instance.questionnaire
    
    answer.class_eval do
      questionnaire.questions.each do |question|
        if question.type == :date

          define_method(question.year_key || "#{question.key}_yyyy") do
            self.value ||= Hash.new
            self.value[question.year_key || "#{question.key}_yyyy"]
          end

          define_method(question.year_key ? "#{question.year_key}=" : "#{question.key}_yyyy=") do |v|
            self.value ||= Hash.new
            self.value[question.year_key || "#{question.key}_yyyy"] = v
          end
          
          define_method(question.month_key || "#{question.key}_mm") do
            self.value ||= Hash.new
            self.value[question.month_key || "#{question.key}_mm"]
          end

          define_method(question.month_key ? "#{question.month_key}=" : "#{question.key}_mm=") do |v|
            self.value ||= Hash.new
            self.value[question.month_key || "#{question.key}_mm"] = v
          end
          
          define_method(question.day_key || "#{question.key}_dd") do
            self.value ||= Hash.new
            self.value[question.day_key ||"#{question.key}_dd"]
          end

          define_method(question.day_key ? "#{question.day_key}=" :"#{question.key}_dd=") do |v|
            self.value ||= Hash.new
            self.value[question.day_key ||"#{question.key}_dd"] = v
          end

          define_method(question.key) do
            self.value ||= Hash.new
            v = [self.value[question.day_key ||"#{question.key}_dd"],
             self.value[question.month_key ||"#{question.key}_mm"],
             self.value[question.year_key ||"#{question.key}_yyyy"]]
            if v.inject(true) {|allblank, it| it.blank? and allblank}
              return ""
            else
              return v.join("-")              
            end            
          end

        elsif question.type == :radio or question.type == :scale or 
          question.type == :string

          define_method(question.key) do
            self.value ||= Hash.new
            self.value[question.key]
          end
  
          define_method(question.key.to_s + "=") do |v|
            self.value ||= Hash.new
            self.value[question.key] = v
          end
        
        elsif question.type == :check_box
        
          define_method(question.key) do
            self.value ||= Hash.new
            self.value[question.key] ||= Hash.new
          end
            
          question.options.each do |opt|
            
            define_method("#{question.key}_#{opt.key}") do
              self.value ||= Hash.new
              self.value[question.key] ||= Hash.new
              self.value[opt.key] ||= 0
            end
            
            define_method("#{question.key}_#{opt.key}=") do |v|
              v = v.to_i
              self.value ||= Hash.new
              self.value[question.key] ||= Hash.new
              self.value[question.key][opt.key] = v
              self.value[opt.key] = v
            end  
          end

        elsif question.type == :integer or question.type == :float
          define_method(question.key) do
            self.value ||= Hash.new
            self.value[question.key]
          end
          
          define_method(question.key.to_s + "=") do |v|
            self.value ||= Hash.new
            self.value[question.key] = v           
          end                
        end rescue nil
      end

      if questionnaire.scores
        questionnaire.scores.each do |score|
          scorer = score.scorer
          define_method("score_" + score.key.to_s, &scorer)
        end
      end
    end
  end
end
