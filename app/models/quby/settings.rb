module Quby
  class Settings
    include Mongoid::AppSettings

    setting :api_allowed_ip_ranges, default: ["10.0.0.0/8"]
    setting :shared_secret
    setting :previous_shared_secret, default: nil
    setting :enforce_questionnaire_key_format, default: true
    setting :enable_leave_page_alert, default: true

    # Authorization protocols
    setting :authorize_with_hmac,            default: true
    setting :authorize_with_id_from_session, default: true
  end
end
