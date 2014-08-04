require 'opencpu'
OpenCPU.configure do |config|
  # only change if set, so apps can configure it outside of quby as well.
  config.endpoint_url = ENV['OPENCPU_ENDPOINT_URL'] if ENV['OPENCPU_ENDPOINT_URL']
  config.username     = ENV['OPENCPU_USERNAME']     if ENV['OPENCPU_USERNAME']
  config.password     = ENV['OPENCPU_PASSWORD']     if ENV['OPENCPU_PASSWORD']
  config.timeout      = ENV['OPENCPU_TIMEOUT'].to_i if ENV['OPENCPU_TIMEOUT']
end
