//
// ダイアログコンポーネント共通の仕組み
//
export default {
  data: function() {
    return {
      isShow: true
    }
  },
  watch: {
    isShow: function(v) {
      if (v) {
        document.getElementsByTagName("body")[0].className="noscroll"
      } else {
        document.body.removeAttribute("class","noscroll")
      }
    }
  }
}
