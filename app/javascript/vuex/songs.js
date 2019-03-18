/**
  楽曲一覧系のストア
*/
import http from '../lib/http'
export default {
  namespaced: true,
  state: {
    // [API Response] 曲名一覧
    songNames: [],
  },
  mutations: {
    setSongNames (state, names) {
      state.songNames = names
    }
  },
  actions: {
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
