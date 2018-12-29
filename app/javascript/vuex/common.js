/**
  各画面共通のストア
*/
import http from '@lib/http'
import { router } from '@lib/routes'
export default {
  namespaced: true,
  state: {
    // ログイン中か？
    isLogin: null,
    // ログイン用トークン
    jwtToken: null,
    // ログイン中ユーザ情報
    currentUser: null,
    // ヘッダーに表示されるページタイトル
    pageTitle: '',
    // 歌唱履歴詳細ダイアログを表示してる？
    isShowHistoryDialog: false,
    // 歌唱履歴詳細ダイアログに表示してる歌唱履歴
    showingHistory: null,
    // カラオケ作成編集ダイアログを表示してる？
    isShowEventDialog: false,
    // カラオケ作成編集ダイアログで表示しているカラオケ
    showingEvent: null,
    // ローディング中か？
    isLoading: false,
  },

  mutations: {
    setIsLogin (state, isLogin) {
      state.isLogin = isLogin
    },
    setJwtToken (state, token) {
      state.jwtToken = token
    },
    setCurrentUser (state, currentUser) {
      state.currentUser = currentUser
    },
    setPageTitle (state, title) {
      state.pageTitle = title
    },
    setIsShowYoutubeDialog (state) {
      state.isShowYoutubeDialog = true
    },
    setIsShowHistoryDialog (state, value) {
      state.isShowHistoryDialog = value
    },
    setShowingHistory (state, history) {
      state.showingHistory = history
    },
    setIsShowEventDialog (state, value) {
      state.isShowEventDialog = value
    },
    setShowingEvent (state, event) {
      state.showingEvent = event
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
    setIsLoading (state) {
      state.isLoading = true
    },
    unsetIsLoading (state) {
      state.isLoading = false
    }
  },
  actions: {
    // ユーザ名/パスワードを用いてログイン
    login ({ commit, dispatch }, {name, password}) {
      dispatch('showLoadingView')

      // TODO: Promise勉強しなおそ
      return http.login(name, password)
        .then((response) => {
          localStorage.setItem('jwt', response.data.jwt)
          commit('setJwtToken', response.data.jwt)
          commit('setIsLogin', true)
          dispatch('hideLoadingView')
          router.go()
        })
        .catch((err) => {
          dispatch('hideLoadingView')
          return Promise.reject()
        })
    },
    // LocalStorage内のトークンを用いてログイン
    loginByToken ({ commit, dispatch }) {
      if (!localStorage.getItem('jwt')) return

      http.getMySelf()
      .then((response) => {
        commit('setCurrentUser', response.data)
      })
      .catch((err) => {
        dispatch('logout')
      })
    },
    // ログアウト
    logout ({ commit }) {
      localStorage.removeItem('jwt')
      commit('setCurrentUser', null)
      router.push('/')
    },
    // ページタイトルを差し替える
    setPageTitle ({ commit }, pageTitle) {
      commit('setPageTitle', pageTitle)
    },
    // 歌唱履歴ダイアログを表示する
    showHistoryDialog ({ commit, dispatch }, historyId) {
      commit('setIsShowHistoryDialog', true)

      http.getHistory(historyId).then((res) => {
        commit('setShowingHistory', res.data)
        router.push({query: { historyDialog: res.data.id }})
      })
    },
    // 歌唱履歴ダイアログを終了する
    hideHistoryDialog ({ commit }) {
      commit('setIsShowHistoryDialog', false)
      commit('setShowingHistory', null)
      const urlQuery = Object.assign({}, router.currentRoute.query)
      delete urlQuery.historyDialog
      router.push({query: urlQuery })
    },
    // カラオケダイアログを表示する
    showEventDialog ({ commit, dispatch }, eventId) {
      commit('setIsShowEventDialog', true)

      // 新規の場合はnullが入ってるので
      if (eventId) {
        return http.getEvent(eventId).then((res) => {
          commit('setShowingEvent', res.data)
          router.push({query: { eventDialog: res.data.id }})
        })
      }
    },
    // 歌唱履歴ダイアログを終了する
    hideEventDialog ({ commit }) {
      commit('setIsShowEventDialog', false)
      commit('setShowingEvent', null)
      const urlQuery = Object.assign({}, router.currentRoute.query)
      delete urlQuery.eventDialog
      router.push({query: urlQuery })
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
