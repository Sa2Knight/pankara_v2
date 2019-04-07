/**
  歌手ページのストア
*/
import http from '../lib/http'
import util from '../lib/util'
import CONST from '../lib/constants'
export default {
  namespaced: true,
  state: {
    // [API Response] 表示中の歌手
    artist: null,
    // [API Response] 表示中の歌手の歌唱履歴
    histories: null,
    // [API Response] 歌手名一覧
    artistNames: [],

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
    setArtistNames (state, names) {
      state.artistNames = names
    },
    setHistoriesPager (state, pager) {
      state.historiesPager = {
        ...state.historiesPager,
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
    //
    // APIから歌手詳細をフェッチ
    //
    fetchArtist ({ commit, dispatch }, id) {
      dispatch('common/showLoadingView', null, { root: true })
      commit('resetArtist')
      commit('resetHistories')
      return http.getArtist(id).then((response) => {
        commit('setArtist', response.data)
        dispatch('common/hideLoadingView', null, { root: true })
      })
    },

    //
    // APIから歌手の歌唱履歴をフェッチ
    // 歌手詳細情報が取得済みであることが前提
    //
    fetchHistoriesByPage ({ state, commit, dispatch }, page) {
      commit('setHistoriesPager', { page: page })
      dispatch('common/showLoadingView', null, { root: true })

      const params = {
        artist_id: state.artist.id,
        page: state.historiesPager.page,
        per:  state.historiesPager.per,
        sort_key: 'event_date',
        sort_order: 'desc'
      }
      return http.getHistories(params).then((response) => {
        commit('setHistories', response.data)
        commit('setHistoriesPager', {
          total: Number(response.headers['total-count']),
          totalPages: Number(response.headers['total-pages'])
        })
        dispatch('common/hideLoadingView', null, { root: true })
        util.scrollToTop() // TODO ページングごとにこれ書いてそう
      })
    },
    //
    // APIから楽曲一覧をフェッチ
    // 連続で呼び出すのと、最悪失敗しても問題ないのでローディング無し
    //
    fetchArtistNames ({ commit, dispatch }, {name = null, songName = null}) {
      const params = {
        name,
        song_name: songName
      }
      return http.getArtistNames(params).then((response) => {
        commit('setArtistNames', response.data)
      })
    }
  }
}
