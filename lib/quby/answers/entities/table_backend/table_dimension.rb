module Quby::Answers::Entities::TableBackend
# TableDimension acts like nodes of a tree, every level consists of an array of table dimensions that each
# have multiple ranges that point to either an array of TableDimensions for the next dimension or
#   a non-TableDimension, which will be seen as a result

# Going down the tree a level is like evaluating dimensions AND-wise,
# going side to side on a level is evaluating dimensions OR-wise
  class TableDimension < Struct.new(:name, :ranges)
    class AcceptsAnythingRange
      include Singleton

      def include?(_)
        true
      end
    end

    def lookup(parameters)
      parameters = parameters.with_indifferent_access
      next_dimensions_or_result = get_dimensions_or_result_for(parameters)
      if next_dimensions_or_result.is_a?(Array) && next_dimensions_or_result.all? { |item| item.is_a?(TableDimension) }
        # find first dimension that gives us a result for the given parameters
        result = nil
        next_dimensions_or_result.find do |dimension|
          result = dimension.lookup(parameters)
        end
        result
      else # it is a result
        next_dimensions_or_result
      end
    end

    private

    def get_dimensions_or_result_for(parameters)
      ranges.find do |range, _|
        relevant_parameter = parameters[name]
        relevant_parameter = relevant_parameter.to_s if relevant_parameter.is_a?(Symbol)
        range.include? relevant_parameter
      end.andand.last
    end
  end
end
