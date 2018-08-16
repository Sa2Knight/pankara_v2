# 各楽曲の、年月ごとの歌唱回数を集計して出力する
histories = History.all.includes([user_event: [:user, :event]])
counts = Hash.new {|h, k| h[k] = 0}

histories.each do |h|
  datetime = h.user_event.event.datetime
  key = "#{h.song_id}_#{datetime.year}_#{datetime.month}"
  counts[key] += 1
end

counts.sort_by { |k, v| v }
