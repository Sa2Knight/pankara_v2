/**
  カラオケ詳細画面のストア
*/
import http from '../lib/http'
export default {
  state: {
    // APIからフェッチしたカラオケ詳細
    event: null,
    // 選択中の歌唱履歴ID
    selectedHistoryId: null
  },

  mutations: {
    setEvent (state, event) {
      state.event = event
    },
    setSelectedHistoryId (state, id) {
      state.selectedHistoryId = id
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
    // 歌唱履歴のうち1件を選択状態にする
    selectHistory ({ commit }, id) {
      commit('setSelectedHistoryId', id)
    }
  }
}
