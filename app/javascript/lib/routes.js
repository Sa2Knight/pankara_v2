const ROUTES = {
  INDEX_PATH: () => '/',
  EVENTS_PATH: () => '/events',
  EVENT_PATH: event_id => `/events/${event_id}`,
  SONG_PATH: song_id => `/songs/${song_id}`,
}

export default ROUTES
