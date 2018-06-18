export default {
  state: {
    selectedHistoryId: null
  },

  mutations: {
    selectHistory (state, id) {
      state.selectedHistoryId = id
    }
  },

  actions: {
    selectHistory ({ commit }, id) {
      commit('selectHistory', id)
    }
  }
}
