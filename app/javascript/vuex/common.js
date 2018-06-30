/**
  各画面共通のストア
*/
import http from '../lib/http'
export default {
  state: {
    // Youtubeダイアログを表示してる？
    isShowYoutubeDialog: false,
    // Youtubeダイアログで表示している楽曲
    showingYoutubeSong: null,
  },

  mutations: {
    setIsShowYoutubeDialog (state) {
      state.isShowYoutubeDialog = true
    },
    setShowingYoutubeSong (state, song) {
      state.showingYoutubeSong = song
    },
    unsetIsShowYoutubeDialog (state) {
      state.isShowYoutubeDialog = false
    },
    unsetShowingYoutubeSong (state) {
      state.showingYoutubeSong = null
    },
  },
  actions: {
    // Youtubeダイアログを表示する
    showYoutubeDialog ({ commit }, song) {
      commit('setIsShowYoutubeDialog')
      commit('setShowingYoutubeSong', song)
    },
    // Youtubeダイアログを終了する
    hideYoutubeDialog ({ commit }) {
      commit('unsetIsShowYoutubeDialog')
      commit('unsetShowingYoutubeSong')
    },
  }
}
