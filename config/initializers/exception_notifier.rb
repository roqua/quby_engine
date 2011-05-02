unless Rails.env.development?
  Quby::Application.config.middleware.use ExceptionNotifier,
   :email_prefix => "[Quby] ",
   :sender_address => %{"Exception Notifier" <noreply@roqua.nl>},
   :exception_recipients => "#{ORGANIZATION}@roqua.nl"
end