<template>
  <div class="v-satisfaction-rate narrow">
    <v-rating v-if="satisfaction"
      :value="satisfaction"
      :length="10"
      hover
      readonly
      color="red lighten-3"
      small
      background-color="gray lighten-1"
    />
    <span v-else-if="emptyString">
      {{ emptyString }}
    </span>
  </div>
</template>

<style lang="scss" scoped>
.narrow {
  /deep/ .v-icon {
    padding: 0;
  }
}
</style>

<script>
  export default {
    props: {
      satisfaction: {
        type: Number,
        required: false
      },
      emptyString: {
        type: String,
        required: false
      },
      // 星のpaddingを0にする場合true
      narrow: {
        type: Boolean,
        required: false,
        default: false
      }
    }
  }
</script>
