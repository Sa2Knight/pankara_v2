module WikipediaWrapper
  module_function

  #
  # 指定したタイトルで記事を検索し、そのサマリーを戻す
  #
  def fetch_sammary(title:)
    Wikipedia.find(title).summary.presence
  end
end
