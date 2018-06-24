/**
  カラオケ一覧画面のストア
*/
import http from '../lib/http'
export default {
  state: {
    // APIからフェッチしたカラオケ一覧
    events: [],
    // APIからフェッチ中であるか？
    isLoading: false,
    // 全カラオケをフェッチ済みか？
    isAllLoaded: false,
  },

  mutations: {
    appendEvents (state, events) {
      state.events = state.events.concat(events)
    },
    setIsLoading (state) {
      state.isLoading = true
    },
    setIsAllLoaded (state) {
      state.isAllLoaded = true
    },
    unsetEvents (state) {
      state.events = []
    },
    unsetIsLoading (state) {
      state.isLoading = false
    },
    unsetIsAllLoaded (state) {
      state.isAllLoaded = false
    },
  },

  actions: {
    // APIからカラオケの詳細を取得する
    fetchEvents ({ commit }, params) {
      commit('setIsLoading')

      http.getEvents(params).then((response) => {
        commit('appendEvents', response.data)
        commit('unsetIsLoading')

        if (response.data.length == 0) {
          commit('setIsAllLoaded')
        } else {
          commit('unsetIsAllLoaded')
        }
      })
    },
  }
}
