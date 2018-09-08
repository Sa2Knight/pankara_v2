source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

# Rails本体
gem 'rails', '~> 5.2.0'

# データベース
gem 'mysql2', '>= 0.4.4', '< 0.6.0'

# 開発用Webサーバ
gem 'puma', '~> 3.11'

# Railsの起動を高速化するやつ
gem 'bootsnap', '>= 1.1.0', require: false

# タイムゾーンを扱うやつ
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# ページングできるようにするやつ
gem 'kaminari'

# 暗号化のやつ
gem 'bcrypt'

# JWT認証用
gem 'knock'

# Wikipediaクライアント
gem 'wikipedia-client'

group :development, :test do
  # Pryによるデバッグ用gem
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-doc'
  # テストデータ生成用
  gem 'factory_bot_rails'
  # テストデータ削除用
  gem 'database_cleaner'
  # N + 1検知用
  gem 'bullet'
end

group :development do
  # ファイル変更を検知するやつ
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # テスティングフレームワーク
  gem 'rspec-rails'
  # E2Eテスト用フレームワーク
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
end
