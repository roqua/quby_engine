# frozen_string_literal: true

module Quby
  module Questionnaires
    module DSL
      module CallsCustomMethods
        attr_reader :custom_methods

        def initialize(*args)
          options = args.last.is_a?(::Hash) ? args.last : {}
          @custom_methods = options[:custom_methods] || {}
          super
        end

        def method_missing(method_sym, *args, &block)
          if @custom_methods.key? method_sym
            instance_exec(*args, &custom_methods[method_sym])
          else
            super
          end
        end

        def respond_to_missing?(method_name, include_private = false)
          custom_methods.key?(method_name) || super
        end
      end
    end
  end
end
