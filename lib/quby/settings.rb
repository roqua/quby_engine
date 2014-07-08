module Quby
  class Settings
    def self.api_allowed_ip_ranges
      @api_allowed_ip_ranges || ["10.0.0.0/8"]
    end

    def self.api_allowed_ip_ranges=(value)
      @api_allowed_ip_ranges = value
    end

    def self.shared_secret
      @shared_secret
    end

    def self.shared_secret=(value)
      @shared_secret = value
    end

    def self.enforce_questionnaire_key_format
      @enforce_questionnaire_key_format || true
    end

    def self.enforce_questionnaire_key_format=(value)
      @enforce_questionnaire_key_format = value
    end

    def self.enable_leave_page_alert
      @enable_leave_page_alert || true
    end

    def self.enable_leave_page_alert=(value)
      @enable_leave_page_alert = value
    end

    # Authorization protocols
    def self.authorize_with_hmac
      @authorize_with_hmac || true
    end

    def self.authorize_with_hmac=(value)
      @authorize_with_hmac = value
    end

    def self.authorize_with_id_from_session
      @authorize_with_id_from_session || true
    end

    def self.authorize_with_id_from_session=(value)
      @authorize_with_id_from_session = value
    end
  end
end
