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

  # アセットパイプラインを使わない
  config.assets.enabled = false
  config.assets.compile = false

  # ActiveStorageはクラウドでなくローカルを使う
  config.active_storage.service = :local

  # ログは警告以上のみ表示
  # REVIEW: デバッグ情報本当にいらない？
  config.log_level = :warn

  # ログにrequest_idを含むようにする
  config.log_tags = [ :request_id ]

  # メールテンプレートのキャッシュはしない
  config.action_mailer.perform_caching = false

  # ローケルに該当する翻訳が存在しない場合デフォルトローけるに戻す
  config.i18n.fallbacks = true

  # 非推奨レポートを通知する
  config.active_support.deprecation = :notify

  # ログ出力のフォーマットを指定
  config.log_formatter = ::Logger::Formatter.new

  # マイグレーション実行後にスキーマダンプを行わない
  config.active_record.dump_schema_after_migration = false
end
