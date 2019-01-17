require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Pankara
  class Application < Rails::Application
    # Rails 5.2の推奨設定を利用
    config.load_defaults 5.2

    # 追加で読み込むファイルを指定
    config.autoload_paths += %W[#{config.root}/app/models/validators]
    config.autoload_paths += %W[#{config.root}/lib]
    Dir["#{config.root}/lib/core_ext/*.rb"].each do |l|
      require l
    end

    # タイムゾーンを日本に
    Rails.application.config.time_zone = 'Tokyo'

    #
    # Generatorの生成物の設定
    # 基本的に必要に応じて手動で生成するので全てオフ
    #
    config.generators do |g|
      g.javascripts false
      g.stylesheets false
      g.helper false
      g.test_framework :rspec,
                       fixture: false,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       controller_specs: false,
                       request_specs: false
    end
  end
end
