module WikipediaWrapper
  module_function

  #
  # 指定したタイトルで記事を検索し、そのサマリーを戻す
  #
  def fetch_summary(title:)
    page = Wikipedia.find(title)
    {
      description: page.summary.presence,
      url: page.content.present? ? page.fullurl : nil
    }
  end
end
