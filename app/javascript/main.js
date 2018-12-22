import Vue        from 'vue'
import Vuex       from 'vuex'
import VueRouter  from 'vue-router'
import Vuetify    from 'vuetify'
import 'vuetify/dist/vuetify.min.css'
import '@fortawesome/fontawesome-free-webfonts/css/fontawesome.css'
import '@fortawesome/fontawesome-free-webfonts/css/fa-solid.css'
import PageLayout from '@component/PageLayout'
import { router } from '@lib/routes'

Vue.use(Vuex)
Vue.use(VueRouter)
Vue.use(Vuetify)

// vuexモジュールを定義
const store = new Vuex.Store({
  modules: {
    events: require('@vuex/events').default,
    event:  require('@vuex/event').default,
    song:   require('@vuex/song').default,
    artist: require('@vuex/artist').default,
    common: require('@vuex/common').default
  }
})

// ページ全体をVueコンポーネント化
new Vue({
  store,
  router,
  components: {
    PageLayout: PageLayout
  }
}).$mount('#app')
