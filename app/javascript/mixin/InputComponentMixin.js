//
// 入力系コンポーネントの共通属性
// valueとlocalValueを持ち、双方向バインディングを実現する
//
export default {
  data: function() {
    return {
      localValue: null
    }
  },
  props: {
    value: {
      required: false
    }
  },
  watch: {
    localValue() {
      this.$emit('input', this.localValue)
    },
    value: {
      handler () {
        this.localValue = this.value
      },
      immediate: true
    }
  }
}
