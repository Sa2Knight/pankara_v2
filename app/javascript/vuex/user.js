/**
  歌唱履歴一覧画面のストア
*/
import http from '@lib/http'
import util from '@lib/util'
import CONST from '@lib/constants'
export default {
  namespaced: true,
  state: {
    // 持ち歌一覧
    mySongs: [],
    // 持ち歌一覧のページャ
    mySongsPager: {
      total: 0,
      totalPages: 0,
      page: 1,
      per: CONST.PER
    },
    // 持ち歌一覧の検索ダイアログが表示されているか
    isShowMySongsSearchDialog: false,
    // 持ち歌一覧の検索条件
    mySongsSearchQuery: {
      name: '',
      artist_name: ''
    }
  },

  mutations: {
    setMySongs (state, mySongs) {
      state.mySongs = mySongs
    },
    setMySongsPager (state, pager) {
      state.mySongsPager = {
        ...state.mySongsPager,
        ...pager
      }
    },
    unsetMySongsPager (state) {
      state.mySongsPager = {
        total: 0,
        totalPages: 0,
        page: 1,
        per: CONST.PER
      }
    },
    setIsShowMySongsSearchDialog (state, val) {
      state.isShowMySongsSearchDialog = val
    },
    setMySongsSearchQuery (state, query) {
      state.mySongsSearchQuery = query
    },
    unsetMySongsSearchQuery (state) {
      state.mySongsSearchQuery = {
        name: '',
        artist_name: ''
      }
    }
  },

  actions: {
    // APIから持ち歌一覧を取得する
    fetchMySongs ({ state, commit, dispatch }, userId) {
      dispatch('common/showLoadingView', null, { root: true })

      const params = {
        ...state.mySongsSearchQuery,
        with_artist: true,
        user_id: userId,
        page: state.mySongsPager.page,
        per: state.mySongsPager.per,
      }
      http.getSongs(params).then((response) => {
        commit('setMySongs', response.data)
        dispatch('common/hideLoadingView', null, { root: true })
        commit('setMySongsPager', {
          total: Number(response.headers['total-count']),
          totalPages: Number(response.headers['total-pages'])
        })
        util.scrollToTop()
      })
    },
    // ページを切り替える
    changePage ({ state, commit }, page) {
      commit('setMySongsPager', { page: page })
    },
    // 持ち歌一覧検索ダイアログを開く
    showMySongsSearchDialog ({ commit }) {
      commit('setIsShowMySongsSearchDialog', true)
    },
    // 検索結果を反映せずに検索ダイアログを閉じる
    cancelMySongsSearchDialog ({ commit }) {
      commit('setIsShowMySongsSearchDialog', false)
    },
    // 検索結果を反映して検索ダイアログを閉じる
    submitMySongsSearchDialog ({ commit }, query) {
      commit('setMySongsSearchQuery', query)
      commit('unsetMySongsPager')
      commit('setIsShowMySongsSearchDialog', false)
    },
  }
}
