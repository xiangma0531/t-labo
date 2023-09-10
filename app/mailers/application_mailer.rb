class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@#{ENV['TLABO_DOMAIN']}"
  layout 'mailer'
end
