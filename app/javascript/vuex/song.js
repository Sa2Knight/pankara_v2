/**
  楽曲ページののストア
*/
import http from '../lib/http'
export default {
  namespaced: true,
  state: {
    // 表示中の楽曲
    song: null,
    // 表示中の楽曲の歌唱履歴
    histories: null
  },
  mutations: {
    setSong (state, song) {
      state.song = song
    },
    resetSong (state) {
      state.song = null
    },
    setHistories (state, histories) {
      state.histories = histories
    },
    unsetSong (state) {
      state.song = null
    },
    unsetHistories (state) {
      state.histories = null
    },
  },
  actions: {
    // APIから楽曲詳細をフェッチ
    fetchSong ({ commit, dispatch }, id) {
      dispatch('common/showLoadingView', null, { root: true })
      commit('resetSong')

      Promise.resolve()
        .then(() => {
          http.getSong(id).then((response) => {
            commit('setSong', response.data)
          })
        }).then(() => {
          http.getSongHistories(id).then((response) => {
            commit('setHistories', response.data)
          })
        }).then(() => {
          dispatch('common/hideLoadingView', null, { root: true })
        })
    },
  }
}
