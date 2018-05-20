import Vue        from 'vue'
import VueRouter  from 'vue-router'

Vue.use(VueRouter)

// URLに対応するコンポーネントを定義
const routes = [
  { path: '/', component: require('./index').default }
]
const router = new VueRouter({
    routes
})

// ページ全体をVueコンポーネント化
const app = new Vue({
  router
}).$mount('#app')
