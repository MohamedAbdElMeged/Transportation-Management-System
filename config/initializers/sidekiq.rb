require 'sidekiq'
require 'sidekiq/web'

Sidekiq.configure_server do |config|
  config.on(:startup) do
    Sidekiq.schedule = YAML.load_file(File.expand_path('../scheduler.yml', File.dirname(__FILE__)))
    Sidekiq::Scheduler.reload_schedule!
  end
  config.redis = { url: "redis://#{ENV['REDIS_HOST']}/0" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{ENV['REDIS_HOST']}/0" }
end

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  Rack::Utils.secure_compare(::Digest::SHA256.hexdigest(user), ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_DASHBOARD_USERNAME'])) &
    Rack::Utils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_DASHBOARD_PASSWORD']))
end
