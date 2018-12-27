Rails.application.configure do

  # ソースに変更を加えてもリロードしない
  config.cache_classes = true

  # 全ての名前空間を事前に読み込む
  config.eager_load = true

  # Railsのエラーをレスポンスに含まない
  config.consider_all_requests_local       = false

  # コンテンツのキャッシュを利用する
  config.action_controller.perform_caching = true

  # Webサーバ(Nginx,Apachなど)を使わずにAssetsファイルを配信させるか
  # TODO: どのように配信するか要検討
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  # JSの圧縮ライブラリにはuglifierを使用
  config.assets.js_compressor = :uglifier

  # アセットのコンパイルは行わない
  # TODO: 要検討
  config.assets.compile = false

  # ActiveStorageはクラウドでなくローカルを使う
  config.active_storage.service = :local

  # ログは警告以上のみ表示
  # REVIEW: デバッグ情報本当にいらない？
  config.log_level = :warn

  # ログにrequest_idを含むようにする
  config.log_tags = [ :request_id ]

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Use a real queuing backend for Active Job (and separate queues per environment)
  # config.active_job.queue_adapter     = :resque
  # config.active_job.queue_name_prefix = "pankara_#{Rails.env}"

  config.action_mailer.perform_caching = false

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Use a different logger for distributed setups.
  # require 'syslog/logger'
  # config.logger = ActiveSupport::TaggedLogging.new(Syslog::Logger.new 'app-name')

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false
end
