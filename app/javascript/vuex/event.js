/**
  カラオケ詳細画面のストア
*/
import http from '../lib/http'
export default {
  state: {
    // APIからフェッチしたカラオケ詳細
    event: null,
  },

  mutations: {
    setEvent (state, event) {
      state.event = event
    },
    unsetEvent (state) {
      state.event = null
    },
  },

  actions: {
    // APIからカラオケの詳細を取得する
    fetchEvent ({ commit }, id) {
      commit('unsetEvent')

      http.getEvent(id).then((response) => {
        commit('setEvent', response.data)
      })
    },
  }
}
