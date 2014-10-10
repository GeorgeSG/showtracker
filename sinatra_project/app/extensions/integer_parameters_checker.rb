module ShowTracker
  # Registers a Sinatra condition that helps validating route parameters as
  # integers. If validation fails, matching is passed to next routes
  module IntegerParameters
    def integer?(name)
      condition do
        is_integer = Integer(params[name]) rescue false
        pass unless is_integer
      end
    end
  end
end
