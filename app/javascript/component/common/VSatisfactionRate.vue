<template>
  <div class="v-satisfaction-rate" :class="{narrow}">
    <v-rating v-if="value"
      v-model="localValue"
      :length="10"
      hover
      :readonly="readonly"
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
.v-rating {
  display: flex;
  justify-content: space-between;
}
.narrow {
  /deep/ .v-icon {
    padding: 0;
  }
}
</style>

<script>
  import InputComponentMixin from '@mixin/InputComponentMixin'
  export default {
    mixins: [InputComponentMixin],
    props: {
      readonly: {
        type: Boolean,
        required: false,
        default: false
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
