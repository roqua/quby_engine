module Quby
  class Engine < Rails::Engine
    # We don't want to isolate, because we want to be able to
    # share models
    isolate_namespace Quby
  end
end
