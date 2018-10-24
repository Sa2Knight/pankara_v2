export default {
  //
  // スクロールを画面上部に強制的に移動する
  //
  scrollToTop: function() {
    window.scrollTo(0, 0)
  },

  //
  // 実数を指定した桁数で丸める
  // @return String
  //
  round: function(number, digit) {
    const num = Math.floor(number * Math.pow(10, digit)) / Math.pow(10, digit)
    const str = num.toString()
    const numbers = str.split('.')
    if (numbers.length == 1) {
      return str + '.' + '0'.repeat(digit)
    } else if (numbers[1].length == digit) {
      return str
    } else {
      return str + '0'.repeat(digit - numbers[1].length)
    }
  }
}
