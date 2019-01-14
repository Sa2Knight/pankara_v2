namespace :histories do
  desc '全てのHistoryモデルのevent_dateを、Eventモデルと同期'

  task sync_history_event_date: :environment do
    History.all.includes(user_event: :event).find_each do |history|
      history.update(event_date: history.user_event.event.date)
    end
  end
end
