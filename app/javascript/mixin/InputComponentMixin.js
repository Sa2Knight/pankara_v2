//
// 入力系コンポーネントの共通属性
//
export default {
  watch: {
    value (val) {
      this.$emit('input', val)
    }
  }
}
