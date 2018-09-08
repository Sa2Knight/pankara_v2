namespace :artists do
  desc '各ArtistモデルにWikipediaからフェッチしたサマリーを保存する'

  task fetch_wikipedia_summary: :environment do
    SLEEP_TIME = 2

    Artist.no_descriptions.each do |artist|
      summary = WikipediaWrapper.fetch_summary(title: artist.name)
      artist.update(
        description: summary[:description],
        url: summary[:url]
      )
      p summary[:description]
      sleep SLEEP_TIME
    end
  end
end
