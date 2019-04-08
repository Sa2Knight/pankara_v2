<template>
  <div class="v-score-type-selector">
    {{ label }}
  </div>
</template>

<script>
  export default {
    props: {
    },
    computed: {
      label: function() {
        if (!this.type) {
          return ''
        }
        return [
          'JOYSOUND 全国採点',
          'JOYSOUND 分析採点',
          'DAM ランキングバトル',
          'DAM 精密採点',
          'その他'
        ][this.type - 1]
      }
    }
  }
</script>
