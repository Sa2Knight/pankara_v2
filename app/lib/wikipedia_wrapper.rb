module WikipediaWrapper
  module_function

  #
  # 指定したタイトルで記事を検索し、そのサマリーを戻す
  #
  def fetch_sammary(title:)
    page = Wikipedia.find(title)
    {
      summary: page.summary.presence,
      url: page.content.present? ? page.fullurl : nil
    }
  end
end
