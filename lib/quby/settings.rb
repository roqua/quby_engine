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

    def self.previous_shared_secret
      @previous_shared_secret
    end

    def self.previous_shared_secret=(value)
      @previous_shared_secret = value
    end

    def self.enforce_questionnaire_key_format
      if @enforce_questionnaire_key_format.nil?
        true
      else
        @enforce_questionnaire_key_format
      end
    end

    def self.enforce_questionnaire_key_format=(value)
      @enforce_questionnaire_key_format = value
    end

    def self.enable_leave_page_alert
      if @enable_leave_page_alert.nil?
        true
      else
        @enable_leave_page_alert
      end
    end

    def self.enable_leave_page_alert=(value)
      @enable_leave_page_alert = value
    end

    # Authorization protocols
    def self.authorize_with_hmac
      if @authorize_with_hmac.nil?
        true
      else
        @authorize_with_hmac
      end
    end

    def self.authorize_with_hmac=(value)
      @authorize_with_hmac = value
    end

    def self.authorize_with_id_from_session
      if @authorize_with_id_from_session.nil?
        true
      else
        @authorize_with_id_from_session
      end
    end

    def self.authorize_with_id_from_session=(value)
      @authorize_with_id_from_session = value
    end
  end
end
