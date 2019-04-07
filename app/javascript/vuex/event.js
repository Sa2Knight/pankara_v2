/**
  カラオケ詳細画面のストア
*/
import http from '../lib/http'
import { ROUTES, router } from '@lib/routes'
export default {
  namespaced: true,
  state: {
    // APIからフェッチしたカラオケ詳細
    event: null,
    // APIからフェッチしたカラオケの歌唱履歴
    histories: null,
  },

  mutations: {
    setEvent (state, event) {
      state.event = event
    },
    unsetEvent (state) {
      state.event = null
    },
    setHistories (state, histories) {
      state.histories = histories
    },
  },

  actions: {
    //
    // APIからカラオケの詳細及び歌唱履歴を全て取得する
    //
    fetchEvent ({ state, dispatch, commit }, id) {
      dispatch('common/showLoadingView', null, { root: true })

      return Promise.resolve()
        .then(() => {
          return http.getEvent(id).then((response) => {
            commit('setEvent', response.data)
          })
        })
        .then(() => {
          const params = {
            event_id: state.event.id,
            per: 100, // それ以上のイベントが出そうならページャ導入
          }
          return http.getHistories(params).then((response) => {
            commit('setHistories', response.data)
          })
        })
        .then(() => {
          dispatch('common/hideLoadingView', null, { root: true })
        })
    },
    //
    // APIにカラオケ新規作成をリクエストする
    //
    createEvent ({ dispatch }, params) {
      dispatch('common/showLoadingView', null, { root: true })

      http.postEvents(params).then((response) => {
        dispatch('common/hideLoadingView', null, { root: true })

        const createdEventId = response.data.id
        router.push(ROUTES.EVENT_PATH(createdEventId))
      })
    },
    //
    // APIにカラオケ更新をリクエストする
    //
    updateEvent ({ commit, dispatch }, { id, params }) {
      dispatch('common/showLoadingView', null, { root: true })

      http.patchEvent(id, params).then((response) => {
        commit('setEvent', response.data)
        dispatch('common/hideLoadingView', null, { root: true })
      })
    }
  }
}
