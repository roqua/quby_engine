# The Rails-settings plugin we use on Roqua doesn't work in Rails 3...
# When we have a moment we'll fork and fix, but this is a temporary stopgap
# given that we don't really need the database-part of rails-settings yet
# anyway.
#
class Settings
  class << self
    def api_allowed_ip_ranges
      ["10.0.0.0/8"]
    end
  end
end
