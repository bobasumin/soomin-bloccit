if Rails.env.development?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    :address        => 'smtp.sendgrid.net',
    :port           => '587',
    :authentication => :plain,
    :user_name      => "app20914967@heroku.com",
    :password       => "3oeron06",
    :domain         => 'heroku.com',
    :enable_starttls_auto => true
  }
end
