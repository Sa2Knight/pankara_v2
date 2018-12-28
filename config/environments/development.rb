Rails.application.configure do

  # ソースに変更を加えた場合次回リクエスト時にリロードする
  config.cache_classes = false

  # 全ての名前空間は事前に読み込まずに必要になった段階で読み込む
  config.eager_load = false

  # Railsのエラーをレスポンスに含む
  config.consider_all_requests_local = true

  # 開発環境では rails dev:cache コマンドでキャッシュを使うかを切り替える
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  # ActiveStorageはクラウドでなくローカルを使う
  config.active_storage.service = :local

  # メール送信に失敗してもエラーを表示しない
  config.action_mailer.raise_delivery_errors = false

  # メールテンプレートのキャッシュはしない
  config.action_mailer.perform_caching = false

  # Railsログに非推奨レポートを出力する
  config.active_support.deprecation = :log

  # ページロード前に全てのmigrationが走っているかを確認する
  config.active_record.migration_error = :page_load

  # ログでSQLをハイライトする
  config.active_record.verbose_query_logs = true

  # 開発環境ではassetのプリプロセッサを実行しない
  config.assets.debug = true

  # assetに対するリクエストをログに出力しない
  config.assets.quiet = true

  # ファイルの変更を検知するクラスを指定
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # Bulletを用いてN+1を検出してログに吐き出す
  config.after_initialize do
    Bullet.enable = true
    Bullet.alert = true
    Bullet.bullet_logger = true
    Bullet.console = true
    Bullet.rails_logger = true
  end
end
