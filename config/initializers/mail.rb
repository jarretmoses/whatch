# ActionMailer::Base.smtp_settings = {
#     :address   => "smtp.mandrillapp.com",
#     :port      => 587,
#     :enable_starttls_auto => true,
#     :user_name => ENV['MANDRILL_USERNAME'],
#     :password  => ENV['MANDRILL_PASSWORD'],
#     :domain    => 'gmail.com'
#   }
  
# ActionMailer::Base.delivery_method = :smtp

# MandrillMailer.configure do |config|
#   config.api_key = ENV['MANDRILL_API_KEY']
# end


  # config.action_mailer.perform_deliveries = true 
  # config.action_mailer.raise_delivery_errors = false
  # config.action_mailer.delivery_method = :smtp
  # config.action_mailer.smtp_settings = {
  #    :address              => "smtp.gmail.com",
  #    :port                 => 587,
  #    :enable_starttls_auto => true,
  #    :user_name            => ENV['MANDRILL_USERNAME'],
  #    :password             => ENV['MANDRILL_PASSWORD'],
  #    :domain               => 'gmail.com',
  #    :authentication       => 'plain'
  # }