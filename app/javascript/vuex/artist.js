/**
  歌手ページのストア
*/
import http from '../lib/http'
import util from '../lib/util'
import CONST from '../lib/constants'
export default {
  namespaced: true,
  state: {
    // 表示中の歌手
    artist: null,
    // 表示中の歌手の歌唱履歴
    histories: null,
    // 歌唱履歴用ページャ
    historiesPager: {
      total: 0,
      totalPages: 0,
      page: 1,
      per: CONST.PER
    },
  },
  mutations: {
    setArtist (state, artist) {
      state.artist = artist
    },
    resetArtist (state) {
      state.artist = null
    },
    setHistories (state, histories) {
      state.histories = histories
    },
    resetHistories (state) {
      state.histories = null
    },
    setHistoriesPager (state, pager) {
      state.historiesPager = {
        ...state.pager,
        ...pager
      }
    },
    unsetHistoriesPager (state) {
      state.historiesPager = {
        total: 0,
        totalPages: 0,
        page: 1,
        per: CONST.PER
      }
    }
  },
  actions: {
    // APIから歌手詳細をフェッチ
    fetchArtist ({ commit, dispatch }, id) {
      dispatch('common/showLoadingView', null, { root: true })
      commit('resetArtist')
      commit('resetHistories')

      // TODO: Promiseの使い方間違ってね
      Promise.resolve()
        .then(() => {
          return http.getArtist(id).then((response) => {
            commit('setArtist', response.data)
          })
        })
        .then(() => {
          return http.getArtistHistories(id).then((response) => {
            commit('setHistories', response.data)
            commit('setPager', {
              total: Number(response.headers['total-count']),
              totalPages: Number(response.headers['total-pages'])
            })
            util.scrollToTop() // TODO ページングごとにこれ書いてそう
          })
        })
        .then(() => {
          dispatch('common/hideLoadingView', null, { root: true })
        })
    },
  }
}
