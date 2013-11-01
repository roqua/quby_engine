module Quby
  module LayoutHelper
    def class_for_current_controller_and_action
      [
        request.path_parameters[:controller].split("/").join(" "),
        request.path_parameters[:action]
      ].join(" ")
    end
  end
end
