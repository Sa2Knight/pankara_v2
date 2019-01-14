# 各楽曲の、年月ごとの歌唱回数を集計して出力する
histories = History.all.includes([user_event: %i[user event]])
counts = Hash.new { |h, k| h[k] = 0 }

histories.each do |h|
  date = h.user_event.event.date
  key = "#{h.song_id}_#{date.year}_#{date.month}"
  counts[key] += 1
end

counts.sort_by { |_, v| v }
