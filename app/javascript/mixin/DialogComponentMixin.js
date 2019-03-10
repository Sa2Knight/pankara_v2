//
// ダイアログコンポーネント共通の仕組み
// TODO: PCでは500px、スマホではフルスクリーンになるようにここで一元化したい
//
export default {
  data: function() {
    return {
      isShow: true
    }
  },
  watch: {
    isShow: {
      handler: function(v) {
        if (v) {
          document.getElementsByTagName("body")[0].className="noscroll"
        }
      },
      immediate: true
    }
  },
  beforeDestroy: function() {
    this.isShow = false
    document.body.removeAttribute("class","noscroll")
  }
}
