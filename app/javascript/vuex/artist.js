/**
  歌手ページのストア
*/
import http from '../lib/http'
export default {
  state: {
    // 表示中の楽曲
    artist: null,
  },
  mutations: {
    setArtist (state, artist) {
      state.artist = artist
    },
    resetArtist (state) {
      state.artist = null
    },
  },
  actions: {
    // APIから歌手詳細をフェッチ
    fetchArtist ({ commit }, id) {
      commit('resetArtist')
      http.getArtist(id).then((response) => {
        commit('setArtist', response.data)
      })
    },
  }
}
