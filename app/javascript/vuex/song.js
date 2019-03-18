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
    // [API Response] 曲名一覧
    songNames: [],
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
    setSongNames (state, names) {
      state.songNames = names
    }
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
    //
    // APIから曲名一覧をフェッチ
    // 連続で呼び出すのと、最悪失敗しても問題ないのでローディング無し
    //
    fetchSongNames ({ commit, dispatch }, name) {
      http.getSongNames({name}).then((response) => {
        commit('setSongNames', response.data)
      })
    }
  }
}
