require 'opencpu'
OpenCPU.configure do |config|
  config.endpoint_url = 'https://staging.opencpu.roqua.nl/ocpu'
  config.username     = 'admin'
  config.password     = 'password'
end
