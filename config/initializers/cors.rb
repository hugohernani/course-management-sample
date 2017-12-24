Rails.application.config.middleware.insert_before Warden::Manager, Rack::Cors do
  allow do
    origins '*'
    resource '*',
      :headers => :any,
      :methods => [:get, :post, :options, :delete, :put]
  end
end
