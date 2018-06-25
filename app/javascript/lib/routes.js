const ROUTES = {
  INDEX_PATH: () => '/',
  EVENTS_PATH: () => '/events',
  EVENT_PATH: event_id => `/events/${event_id}`
}

export default ROUTES
