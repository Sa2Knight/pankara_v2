import Vue        from 'vue'
import Vuex       from 'vuex'
import VueRouter  from 'vue-router'
import Vuetify    from 'vuetify'
import 'vuetify/dist/vuetify.min.css'
import '@fortawesome/fontawesome-free-webfonts/css/fontawesome.css'
import '@fortawesome/fontawesome-free-webfonts/css/fa-solid.css'
import Event      from './vuex/modules/event'
import PageLayout from './component/PageLayout'
import PageEvents from './component/page/events/PageEvents'
import PageEvent  from './component/page/event/PageEvent'

Vue.use(Vuex)
Vue.use(VueRouter)
Vue.use(Vuetify)

// URLに対応するコンポーネントを定義
const routes = [
  { path: '/', component: PageEvents },
  { path: '/events/:id', component: PageEvent },
]

// vuexモジュールを定義
const store = new Vuex.Store({
  modules: {
    event: Event
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
