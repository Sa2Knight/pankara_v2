//
// ダイアログコンポーネント共通の仕組み
// TODO: PCでは500px、スマホではフルスクリーンになるようにここで一元化したい
//
export default {
  data: function() {
    return {
      isShow: true,
      scrollY: 0
    }
  },
  watch: {
    isShow: {
      handler: function(v) {
        if (v) {
          this.scrollY = window.pageYOffset
          document.getElementsByTagName("body")[0].className="noscroll"
        }
      },
      immediate: true
    }
  },
  beforeDestroy: function() {
    this.isShow = false
    document.body.removeAttribute("class","noscroll")
    window.scrollTo(0, this.scrollY)
  }
}
