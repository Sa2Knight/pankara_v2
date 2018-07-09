<template>
  <span class="v-stars">
    <span v-if="value">
      <v-icon :key="i" v-for="i in max" size="1em">
        {{ iconLabel(i) }}
      </v-icon>
    </span>
    <span v-else>
      {{ nullString }}
    </span>
  </span>
</template>

<script>
  export default {
    methods: {
      iconLabel: function(i) {
        return i <= this.value ? 'star' : 'star_border'
      },
    },
    props: {
      max: {
        type: Number,
        required: false,
        default: 10
      },
      value: {
        type: Number,
        required: false,
        default: null,
      },
      nullString: {
        type: String,
        required: false,
        default: '未登録'
      }
    }
  }
</script>
