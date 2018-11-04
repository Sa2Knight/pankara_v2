<template>
  <div class="v-satisfaction-rate">
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
      }
    }
  }
</script>
