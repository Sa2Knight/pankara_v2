/**
  歌唱履歴一覧画面のストア
*/
import http from '@lib/http'
import util from '@lib/util'
import CONST from '@lib/constants'
export default {
  namespaced: true,
  state: {
    // APIからフェッチした歌唱履歴一覧
    histories: [],
    // ページャ
    pager: {
      total: 0,
      totalPages: 0,
      page: 1,
      per: CONST.PER
    },
  },

  mutations: {
    setHistories (state, histories) {
      state.histories = histories
    },
    setPager (state, pager) {
      state.pager = {
        ...state.pager,
        ...pager
      }
    },
    unsetPager (state) {
      state.pager = {
        total: 0,
        totalPages: 0,
        page: 1,
        per: CONST.PER
      }
    }
  },

  actions: {
    // APIから歌唱履歴の詳細を取得する
    fetchHistories ({ state, commit, dispatch }, user_id) {
      dispatch('common/showLoadingView', null, { root: true })

      const params = {
        user_id: user_id,
        page: state.pager.page,
        per: state.pager.per,
        sort_order: 'desc',
      }
      http.getHistories(params).then((response) => {
        commit('setHistories', response.data)
        dispatch('common/hideLoadingView', null, { root: true })
        commit('setPager', {
          total: Number(response.headers['total-count']),
          totalPages: Number(response.headers['total-pages'])
        })
        util.scrollToTop()
      })
    },
    // ページを切り替える
    changePage ({ state, commit }, page) {
      commit('setPager', { page: page })
    },
  }
}
