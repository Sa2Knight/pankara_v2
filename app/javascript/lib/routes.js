import VueRouter from 'vue-router'

export const ROUTES = {
  INDEX_PATH: () => '/',
  EVENTS_PATH: () => '/events',
  EVENT_PATH: event_id => `/events/${event_id}`,
  SONG_PATH: song_id => `/songs/${song_id}`,
  ARTIST_PATH: artist_id => `/artists/${artist_id}`,
}

export const router = (() => {
  const routes = [
    {
      name: 'Index',
      path: ROUTES.INDEX_PATH(),
      redirect: ROUTES.EVENTS_PATH()
    },
    {
      name: 'Events',
      path: ROUTES.EVENTS_PATH(),
      component: require('@component/page/events/PageEvents').default
    },
    {
      name: 'Event',
      path: ROUTES.EVENT_PATH(':id'),
      component: require('@component/page/event/PageEvent').default
    },
    {
      name: 'Song',
      path: ROUTES.SONG_PATH(':id'),
      component: require('@component/page/song/PageSong').default
    },
    {
      name: 'Artist',
      path: ROUTES.ARTIST_PATH(':id'),
      component: require('@component/page/artist/PageArtist').default
    },
  ]
  return new VueRouter({ routes })
})()
