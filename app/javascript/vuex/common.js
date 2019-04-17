/**
  各画面共通のストア
  TODO: ダイアログ系はモジュール分割したほうがよさげ
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
    // 歌唱履歴編集ダイアログを表示してる？
    isShowEditableHistoryDialog: false,
    // 歌唱履歴編集ダイアログに表示してる歌唱履歴
    showingEditableHistory: null,
    // カラオケ作成編集ダイアログを表示してる？
    isShowEventDialog: false,
    // カラオケ作成編集ダイアログで表示しているカラオケ
    showingEvent: null,
    // ローディング中か？
    isLoading: false,
    // スナックバーの表示状態
    snackBarStyle: null,
    // スナックバーのテキスト
    snackBarText: ''
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
    setIsShowEditableHistoryDialog (state, value) {
      state.isShowEditableHistoryDialog = value
    },
    setShowingHistory (state, history) {
      state.showingHistory = history
    },
    setShowingEditableHistory (state, history) {
      state.showingEditableHistory = history
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
    },
    setSnackBar (state, {style, text}) {
      if (style === 'success' || style === 'error') {
        state.snackBarStyle = style
        state.snackBarText = text
      } else {
        state.snackBarStyle = null
        state.snackBarText = ''
      }
    }
  },
  actions: {
    // ユーザ名/パスワードを用いてログイン
    login ({ commit, dispatch }, {name, password}) {
      dispatch('showLoadingView')

      return http.login(name, password)
        .then((response) => {
          localStorage.setItem('jwt', response.data.jwt)
          commit('setJwtToken', response.data.jwt)
          commit('setIsLogin', true)
          location.reload()
        })
        .catch((err) => {
          dispatch('showErrorSnackBar', 'ログインに失敗しました')
        })
        .then(() => {
          dispatch('hideLoadingView')
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
    logout ({ commit, dispatch }) {
      localStorage.removeItem('jwt')
      commit('setCurrentUser', null)
      dispatch('showSuccessSnackBar', 'ログアウトしました')
      router.push('/')
    },
    // ページタイトルを差し替える
    setPageTitle ({ commit }, pageTitle) {
      commit('setPageTitle', pageTitle)
    },
    // 歌唱履歴ダイアログを表示する
    showHistoryDialog ({ commit, dispatch }, historyId) {
      dispatch('showLoadingView')
      commit('setIsShowHistoryDialog', true)

      http.getHistory(historyId).then((res) => {
        commit('setShowingHistory', res.data)
        dispatch('hideLoadingView')
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
    // 歌唱履歴編集ダイアログを表示する
    showEditableHistoryDialog ({ commit, dispatch }, historyId = null) {
      commit('setIsShowEditableHistoryDialog', true)
      if (!historyId) return

      dispatch('showLoadingView')
      http.getHistory(historyId).then((res) => {
        commit('setShowingEditableHistory', res.data)
        dispatch('hideLoadingView')
      })
    },
    // 歌唱履歴編集ダイアログを終了する
    hideEditableHistoryDialog ({ commit }) {
      commit('setIsShowEditableHistoryDialog', false)
      commit('setShowingEditableHistory', null)
    },
    // カラオケダイアログを表示する
    showEventDialog ({ commit, dispatch }, event) {
      if (event) { commit('setShowingEvent', event) }
      commit('setIsShowEventDialog', true)
    },
    // 歌唱履歴ダイアログを終了する
    hideEventDialog ({ commit }) {
      commit('setIsShowEventDialog', false)
      commit('setShowingEvent', null)
      const urlQuery = Object.assign({}, router.currentRoute.query)
      delete urlQuery.eventDialog
      router.push({query: urlQuery })
    },
    // 歌唱履歴を新規作成する
    createHistory ({ commit, dispatch }, params) {
      dispatch('showLoadingView')
      return http.postHistories(params)
              .then((res) => {
                commit('setShowingEditableHistory', res.data)
                dispatch('hideEditableHistoryDialog')
                dispatch('showSuccessSnackBar', '歌唱履歴を作成しました')
              })
              .catch((err) => {
                dispatch('showErrorSnackBar', err.response.data.message)
              })
              .then(() => {
                dispatch('hideLoadingView')
              })
    },
    // ローディングビューを表示する
    showLoadingView ({ commit }) {
      commit('setIsLoading')
    },
    // ローディングビューを非表示にする
    hideLoadingView ({ commit }) {
      commit('unsetIsLoading')
    },
    // 正常系スナックバーを表示する
    showSuccessSnackBar ({ commit }, text) {
      commit('setSnackBar', {style: 'success', text})
    },
    // 異常系スナックバーを表示する
    showErrorSnackBar ({ commit }, text) {
      commit('setSnackBar', {style: 'error', text})
    },
    // スナックバーを非表示にする
    hideSnackBar ({ commit }) {
      commit('setSnackBar', {style: null, text: ''})
    }
  }
}
