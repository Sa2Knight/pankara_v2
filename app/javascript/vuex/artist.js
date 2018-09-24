/**
  歌手ページのストア
*/
import http from '../lib/http'
export default {
  state: {
    // 表示中の歌手
    artist: null,
    // 表示中の歌手の歌唱履歴
    histories: null,
  },
  mutations: {
    setArtist (state, artist) {
      state.artist = artist
    },
    resetArtist (state) {
      state.artist = null
    },
    setHistories (state, histories) {
      state.histories = histories
    },
    resetHistories (state) {
      state.histories = null
    }
  },
  actions: {
    // APIから歌手詳細をフェッチ
    fetchArtist ({ commit, dispatch }, id) {
      dispatch('showLoadingView')
      commit('resetArtist')
      commit('resetHistories')

      // TODO: Promiseの使い方間違ってね
      Promise.resolve()
        .then(() => {
          http.getArtist(id).then((response) => {
            commit('setArtist', response.data)
          })
        })
        .then(() => {
          http.getArtistHistories(id).then((response) => {
            commit('setHistories', response.data)
          })
        })
        .then(() => {
          dispatch('hideLoadingView')
        })
    },
  }
}
