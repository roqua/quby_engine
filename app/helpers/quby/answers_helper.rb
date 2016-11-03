module Quby
  module AnswersHelper
    def get_validation_json(validations)
      result = {}
      validations.each_pair do |qkey, valar|
        result[qkey] = valar.map do |val|
          if val[:type] == :regexp
            valc = val.clone
            valc[:matcher] = valc[:matcher].source.to_s
            # Replace single backslashes with two backslashes
            valc[:matcher].gsub!("\\", "\\\\")
            valc
          else
            val
          end
        end
      end
      result.to_json
    end

    def different_header(item, previous_item)
      return true unless item.score_header == previous_item.andand.score_header && previous_item.respond_to?(:options)
      case item.score_header
      when :question_description
        return item.description != previous_item.description
      when :value
        return previous_item.options.map(&:value) != item.options.map(&:value)
      when :description
        return previous_item.options.map(&:description) != item.options.map(&:description)
      end
    end

    def get_question(table, rowi, j)
      q = get_item(table, rowi, j)
      q.is_a?(Quby::Questionnaires::Entities::Question) ? q : nil
    end

    def get_item(table, rowi, j)
      table.item_table[rowi][j]
    end

    def light_dark_for(cyclei, same_question)
      if same_question
        return ""
      elsif cyclei.modulo(2) == 0
        return "light"
      else
        return "dark"
      end
    end
  end
end
