module Quby
  module Questionnaires
    module DSL
      module Helpers
        def image_tag(*args)
          ActionController::Base.helpers.image_tag(*args)
        end
      end
    end
  end
end
