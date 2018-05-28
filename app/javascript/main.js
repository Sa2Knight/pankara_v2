import Vue        from 'vue'
import VueRouter  from 'vue-router'
import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'

Vue.use(VueRouter)
Vue.use(Vuetify)

// URLに対応するコンポーネントを定義
const routes = [
  { path: '/', component: require('./component/page/PageEvents').default }
]

// ページ全体をVueコンポーネント化
const app = new Vue({
  router: new VueRouter({ routes })
}).$mount('#app')
