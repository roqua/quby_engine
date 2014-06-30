module Quby
  module Questionnaires
    module Repos
      class Base
        def all
          fail NotImplementedError
        end

        def find(key)
          fail NotImplementedError
        end

        def exists?(key)
          fail NotImplementedError
        end

        private

        def entity(key, definition, timestamp)
          Quby::Questionnaires::DSL.build(key, definition, timestamp: timestamp)
        end
      end
    end
  end
end
