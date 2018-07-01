/**
  楽曲ページののストア
*/
import http from '../lib/http'
export default {
  state: {
    // 表示中の楽曲
    song: null
  },
  mutations: {
    setSong (state, song) {
      state.song = song
    },
    unsetSong (state) {
      state.song = null
    },
  },
  actions: {
    // APIから楽曲詳細をフェッチ
    fetchSong ({ commit }, id) {
      http.getSong(id).then((response) => {
        commit('setSong', response.data)
      })
    },
  }
}
