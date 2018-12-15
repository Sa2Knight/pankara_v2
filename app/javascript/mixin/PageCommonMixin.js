//
// Pageコンポーネントの共通処理を定義するミックスイン
//
export default {
  // Page描画時に歌唱履歴詳細アイログは閉じる
  mounted: function() {
    this.$store.dispatch('common/hideHistoryDialog')
  }
}
