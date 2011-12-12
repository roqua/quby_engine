module Quby
  class Settings
    include Mongoid::AppSettings

    setting :api_allowed_ip_ranges,            :default => ["10.0.0.0/8"]
    setting :shared_secret,                    :default => "77933b02b53df8c62c94e0e2959165a728aaa4504b49e14be76e31a499469ab5"
    setting :exception_email,                  :default => "#{ORGANIZATION}@roqua.nl"
    setting :enforce_questionnaire_key_format, :default => true
  end
end