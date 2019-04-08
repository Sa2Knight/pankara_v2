<template>
  <div class="v-score-type-selector">
    <v-select
      v-model="localValue"
      label="採点種別"
      :items="scoreTypes"
      item-text="label"
      item-value="id"
    />
  </div>
</template>

<script>
  import InputComponentMixin from '@mixin/InputComponentMixin'
  export default {
    mixins: [InputComponentMixin],

    computed: {
      initialItem: () => {
        return { id: null, label: '採点なし' }
      },
      scoreTypes: function() {
        return [
          this.initialItem,
          { id: 1, label: 'JOYSOUND 全国採点' },
          { id: 2, label: 'JOYSOUND 分析採点' },
          { id: 3, label: 'DAM ランキングバトル' },
          { id: 4, label: 'DAM 精密採点' },
          { id: 5, label: 'その他' }
        ]
      }
    },
  }
</script>
