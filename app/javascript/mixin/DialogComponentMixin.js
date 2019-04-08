//
// ダイアログコンポーネント共通の仕組み
//
export default {
  data: function() {
    return {
      isShow: true,
      isMobile: true,
      scrollY: 0
    }
  },

  methods: {
    onResize () {
      this.isMobile = window.innerWidth < 600
    }
  },

  watch: {
    isShow: {
      handler: function(v) {
        if (v) {
          this.scrollY = window.pageYOffset
          if (this.isMobile) {
            document.getElementsByTagName("body")[0].className="noscroll"
          }
        }
      },
      immediate: true
    }
  },

  mounted: function() {
    this.onResize()
    window.addEventListener('resize', this.onResize, { passive: true })
  },

  beforeDestroy: function() {
    this.isShow = false
    window.removeEventListener('resize', this.onResize, { passive: true })
    document.body.removeAttribute("class","noscroll")
    if (this.isMobile) {
      window.scrollTo(0, this.scrollY)
    }
  }
}
