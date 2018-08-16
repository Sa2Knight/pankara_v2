/**
  楽曲ページののストア
*/
import http from '../lib/http'
export default {
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
    fetchSong ({ commit }, id) {
      http.getSong(id).then((response) => {
        commit('setSong', response.data)
      })
      http.getSongHistories(id).then((response) => {
        commit('setHistories', response.data)
      })
    },
  }
}
