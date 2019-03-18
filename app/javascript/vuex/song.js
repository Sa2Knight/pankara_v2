/**
  楽曲ページののストア
*/
import http from '../lib/http'
export default {
  namespaced: true,
  state: {
    // [API Response] 楽曲
    song: null,
    // [API Response] 楽曲の歌唱履歴
    histories: null,
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
    //
    // APIから楽曲詳細及び歌唱履歴をフェッチ
    //
    fetchSong ({ commit, dispatch }, id) {
      dispatch('common/showLoadingView', null, { root: true })
      commit('resetSong')

      return Promise.resolve()
        .then(() => {
          return http.getSong(id).then((response) => {
            commit('setSong', response.data)
          })
        }).then(() => {
          const params = {
            song_id: id,
            sort_key: 'event_date',
            sort_order: 'desc',
            per: 100, // TODO ページャ対応
          }
          return http.getHistories(params).then((response) => {
            commit('setHistories', response.data)
          })
        }).then(() => {
          return dispatch('common/hideLoadingView', null, { root: true })
        })
    },
  }
}
