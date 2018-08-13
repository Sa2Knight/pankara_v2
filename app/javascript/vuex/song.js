/**
  楽曲ページののストア
*/
import http from '../lib/http'
export default {
  state: {
    // 表示中の楽曲
    song: null,
    // 表示中の楽曲の歌唱履歴
    histories: null
  },
  mutations: {
    setSong (state, song) {
      state.song = song
      // TODO: サーバ側実装して差し替える
      state.song.graph = {
        histories_by_month: {
          '2016': Array.apply(null, new Array(12)).map(() => Math.floor(Math.random() * 9)),
          '2017': Array.apply(null, new Array(12)).map(() => Math.floor(Math.random() * 9)),
          '2018': Array.apply(null, new Array(12)).map(() => Math.floor(Math.random() * 9)),
        },
        satisfactions: Array.apply(null, new Array(10)).map(() => Math.floor(Math.random() * 7)),
        scores_by_score_type: {
          max: Array.apply(null, new Array(5)).map(() => Math.floor(Math.random() * 30) + 70),
          avg: Array.apply(null, new Array(5)).map(() => Math.floor(Math.random() * 30) + 70),
        },
        histories_by_user: {
          labels: ['ないと', 'ともちん', 'へたれ', 'ちゃら'],
          data: Array.apply(null, new Array(4)).map(() => Math.floor(Math.random() * 20))
        }
      }
    },
    setHistories (state, histories) {
      state.histories = histories
    },
    unsetSong (state) {
      state.song = null
    },
    unsetHistories (state) {
      state.histories = null
    },
  },
  actions: {
    // APIから楽曲詳細をフェッチ
    fetchSong ({ commit }, id) {
      http.getSong(id).then((response) => {
        commit('setSong', response.data)
      })
      http.getSongHistories(id).then((response) => {
        commit('setHistories', response.data)
      })
    },
  }
}
