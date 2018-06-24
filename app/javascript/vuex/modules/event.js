/**
  カラオケ詳細画面のストア
*/
import http from '../../lib/http'
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
    unsetEvent (state, event) {
      state.event = null
    },
    setSelectedHistoryId (state, id) {
      state.selectedHistoryId = id
    }
  },

  actions: {
    fetchEvent ({ commit }, id) {
      commit('unsetEvent')
      http.getEvent(id).then((response) => {
        commit('setEvent', response.data)
      })
    },
    selectHistory ({ commit }, id) {
      commit('setSelectedHistoryId', id)
    }
  }
}
