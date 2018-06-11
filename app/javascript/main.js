import Vue        from 'vue'
import VueRouter  from 'vue-router'
import Vuetify    from 'vuetify'
import 'vuetify/dist/vuetify.min.css'
import '@fortawesome/fontawesome-free-webfonts/css/fontawesome.css'
import '@fortawesome/fontawesome-free-webfonts/css/fa-solid.css'
import PageLayout from './component/PageLayout'
import PageEvents from './component/page/PageEvents'

Vue.use(VueRouter)
Vue.use(Vuetify)

// URLに対応するコンポーネントを定義
const routes = [
  { path: '/', component: PageEvents }
]

// ページ全体をVueコンポーネント化
new Vue({
  router: new VueRouter({ routes }),
  components: {
    PageLayout: PageLayout
  }
}).$mount('#app')
