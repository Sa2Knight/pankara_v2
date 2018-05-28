/*
 * スクロールが一番下に到達しているかを戻す
 * @return {boolean} 到達していたらTrue
 */
export const scrollIsBottom = function(tolerance = 200) {
  const top = document.body.scrollTop || document.documentElement.scrollTop;
  const height = document.body.scrollHeight || document.documentElement.scrollHeight;
  const position = window.innerHeight + top;
  return height - position <= tolerance;
}
