module EngineControllerTesting
  # Rails Engines are not really well-supported by RSpec-Rails,
  # they need a use_route: 'quby' in order to find the right route from
  # RSpec controller tests. This module helps accomplish that.

  def get(action, parameters = nil, session = nil, flash = nil)
    process_action(action, parameters, session, flash, "GET")
  end

  # Executes a request simulating POST HTTP method and set/volley the response
  def post(action, parameters = nil, session = nil, flash = nil)
    process_action(action, parameters, session, flash, "POST")
  end

  # Executes a request simulating PUT HTTP method and set/volley the response
  def put(action, parameters = nil, session = nil, flash = nil)
    process_action(action, parameters, session, flash, "PUT")
  end

  # Executes a request simulating DELETE HTTP method and set/volley the response
  def delete(action, parameters = nil, session = nil, flash = nil)
    process_action(action, parameters, session, flash, "DELETE")
  end

  private

  def process_action(action, parameters = nil, session = nil, flash = nil, method = "GET")
    parameters ||= {}
    if Rails::VERSION::MAJOR < 4
      process(action, parameters.merge!(use_route: :quby), session, flash, method)
    elsif Rails::VERSION::MAJOR < 5
      process(action, method, parameters.merge!(use_route: :quby), session, flash)
    else
      process(action, method, params: parameters.merge!(use_route: :quby), session: session, flash: flash)
      # process(
      #   action: action,
      #   method: method,
      #   params: parameters.merge!(use_route: :quby),
      #   session: session,
      #   flash: flash
      # )
    end
  end
end
