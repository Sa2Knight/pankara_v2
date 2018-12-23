//
// Pageコンポーネントの共通処理を定義するミックスイン
//
import { mapState } from 'vuex'
export default {
  computed: {
    ...mapState('common', {
      currentUser: state => state.currentUser
    }),
    isLogin: function() {
      return !!this.currentUser
    }
  },
  watch: {
    // URLの変更を検知して、ダイアログの非表示を切り替え
    '$route': {
      handler (from, to) {
        if (this.$route.query.historyDialog) {
          const historyId = this.$route.query.historyDialog
          this.$store.dispatch('common/showHistoryDialog', historyId)
        } else {
          this.$store.dispatch('common/hideHistoryDialog')
        }
      },
      immediate: true
    }
  }
}
