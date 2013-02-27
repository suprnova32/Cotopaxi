Airbrake.configure do |config|
  config.api_key = '8403539d54d208ef021851e68df606aa'
  config.host    = 'errors.mhm-hr.com'
  config.port    = 443
  config.secure  = config.port == 443
end