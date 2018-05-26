<template>
  <div>
    <span>{{ store.name }}</span>
    <span v-if="showBranch">{{ store.branch }}</span>
  </div>
</template>

<script>
  export default {
    props: {
      data: function() {
      },
      // Storeオブジェクト
      // nameとbranchを持つことを期待する
      store: {
        type: Object,
        required: true
      },
      // 支店名まで表示するか
      showBranch: {
        type: Boolean,
        required: false,
        default:  true
      }
    }
  }
</script>
