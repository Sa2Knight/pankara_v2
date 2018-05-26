import Vue        from 'vue'
import VueRouter  from 'vue-router'
import Buefy from 'buefy'
import 'buefy/lib/buefy.css'

Vue.use(VueRouter)
Vue.use(Buefy)

// URLに対応するコンポーネントを定義
const routes = [
  { path: '/', component: require('./component/page/events').default }
]
const router = new VueRouter({
    routes
})

// ページ全体をVueコンポーネント化
const app = new Vue({
  router
}).$mount('#app')
