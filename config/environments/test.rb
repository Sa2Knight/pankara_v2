Rails.application.configure do

  # ソースに変更を加えた場合次回リクエスト時にリロードする
  # REVIEW: falseでよくない？
  config.cache_classes = true

  # 全ての名前空間を事前に読み込まない
  # テスト内で使わないクラスとかもたくさんあると思うので
  config.eager_load = false

  # public以下のファイルは公開する
  # REVIEW: testではいらないかも
  config.public_file_server.enabled = true
  config.public_file_server.headers = {
    'Cache-Control' => "public, max-age=#{1.hour.to_i}"
  }

  # Railsのエラーをレスポンスに含める
  config.consider_all_requests_local       = true

  # コンテンツのキャッシュは使わない。テストなので
  config.action_controller.perform_caching = false

  # 独自のエラーページは使わずに普通にエラーを返す
  config.action_dispatch.show_exceptions = false

  # testではCSRF保護をしない
  config.action_controller.allow_forgery_protection = false

  # メールテンプレートのキャッシュはしない
  config.action_mailer.perform_caching = false

  # メール送信は行わない
  config.action_mailer.delivery_method = :test

  # 非推奨レポートは標準出力する
  config.active_support.deprecation = :stderr

end
