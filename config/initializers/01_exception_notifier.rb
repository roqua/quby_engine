if not (Rails.env.development? or Rails.env.test?)
  Quby::Application.config.middleware.use ExceptionNotifier,
   :email_prefix => "[Quby] ",
   :sender_address => %{"Exception Notifier" <noreply@roqua.nl>},
   :exception_recipients => Settings.exception_email || "#{Settings.organization}@roqua.nl"
end