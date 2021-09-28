require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GolfFriends
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.i18n.default_locale = :ja #日本語化する
    config.time_zone = 'Asia/Tokyo' #タイムゾーンを日本時間にする
    config.active_storage.variable_content_types += ['image/heic', 'image/heic-sequence', 'image/heif', 'image/heif-sequence']
  end
end
