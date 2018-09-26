/**
  各画面共通のストア
*/
import http from '../lib/http'
export default {
  namespaced: true,
  state: {
    // ヘッダーに表示されるページタイトル
    pageTitle: '',
    // Youtubeダイアログを表示してる？
    isShowYoutubeDialog: false,
    // Youtubeダイアログで表示している楽曲
    showingYoutubeSong: null,
    // 歌唱履歴詳細ダイアログを表示してる？
    isShowHistoryDialog: false,
    // 歌唱履歴詳細ダイアログに表示してる歌唱履歴
    showingHistory: null,
    // ローディング中か？
    isLoading: false,
  },

  mutations: {
    setPageTitle (state, title) {
      state.pageTitle = title
    },
    setIsShowYoutubeDialog (state) {
      state.isShowYoutubeDialog = true
    },
    setShowingYoutubeSong (state, song) {
      state.showingYoutubeSong = song
    },
    setIsShowHistoryDialog (state) {
      state.isShowHistoryDialog = true
    },
    setShowingHistory (state, history) {
      state.showingHistory = history
    },
    unsetPageTitle (state) {
      state.pageTitle = ''
    },
    unsetIsShowYoutubeDialog (state) {
      state.isShowYoutubeDialog = false
    },
    unsetShowingYoutubeSong (state) {
      state.showingYoutubeSong = null
    },
    unsetIsShowHistoryDialog (state) {
      state.isShowHistoryDialog = false
    },
    unsetShowingHistory (state) {
      state.showingHistory = null
    },
    setIsLoading (state) {
      state.isLoading = true
    },
    unsetIsLoading (state) {
      state.isLoading = false
    }
  },
  actions: {
    // ページタイトルを差し替える
    setPageTitle ({ commit }, pageTitle) {
      commit('setPageTitle', pageTitle)
    },
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
    // 歌唱履歴ダイアログを表示する
    showHistoryDialog ({ commit, dispatch }, historyId) {
      dispatch('showLoadingView')
      commit('setIsShowHistoryDialog')

      http.getHistory(historyId).then((res) => {
        commit('setShowingHistory', res.data)
        dispatch('hideLoadingView')
      })
    },
    // 歌唱履歴ダイアログを終了する
    hideHistoryDialog ({ commit }) {
      commit('unsetIsShowHistoryDialog')
      commit('unsetShowingHistory')
    },
    // ローディングビューを表示する
    showLoadingView ({ commit }) {
      commit('setIsLoading')
    },
    // ローディングビューを非表示にする
    hideLoadingView ({ commit }) {
      commit('unsetIsLoading')
    }
  }
}
