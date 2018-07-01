import Vue        from 'vue'
import Vuex       from 'vuex'
import VueRouter  from 'vue-router'
import Vuetify    from 'vuetify'
import 'vuetify/dist/vuetify.min.css'
import '@fortawesome/fontawesome-free-webfonts/css/fontawesome.css'
import '@fortawesome/fontawesome-free-webfonts/css/fa-solid.css'
import PageLayout from './component/PageLayout'
import ROUTES     from './lib/routes'

Vue.use(Vuex)
Vue.use(VueRouter)
Vue.use(Vuetify)

// URLに対応するコンポーネントを定義
const routes = [
  { path: ROUTES.EVENTS_PATH(),     component: require('./component/page/event/PageEvent').default },
  { path: ROUTES.EVENT_PATH(':id'), component: require('./component/page/events/PageEvents').default },
  { path: ROUTES.SONG_PATH(':id'),  component: require('./component/page/song/PageSong').default },
]

// vuexモジュールを定義
const store = new Vuex.Store({
  modules: {
    events: require('./vuex/events').default,
    event:  require('./vuex/event').default,
    song:   require('./vuex/song').default,
    common: require('./vuex/common').default,
  }
})

// ページ全体をVueコンポーネント化
new Vue({
  store,
  router: new VueRouter({ routes }),
  components: {
    PageLayout: PageLayout
  }
}).$mount('#app')
