const ROUTES = {
  INDEX_PATH: () => '/',
  EVENTS_PATH: () => '/events',
  EVENT_PATH: event_id => `/events/${event_id}`,
  SONG_PATH: song_id => `/songs/${song_id}`,
  ARTIST_PATH: artist_id => `/artists/${artist_id}`,
}

export default ROUTES
