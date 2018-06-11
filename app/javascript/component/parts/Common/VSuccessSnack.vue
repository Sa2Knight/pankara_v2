<template>
  <div>
    <v-snackbar
      v-model="isShow"
      color="success"
      :timeout="timeout"
    >
      <slot></slot>
      <v-btn dark flat @click.native="isShow = false">閉じる</v-btn>
    </v-snackbar>
  </div>
</template>

<script>
  export default {
    data: function() {
      return {
        isShow: false
      }
    },
    props: {
      timeout: {
        type: Number,
        required: false,
        default: 5000
      },
    }
  }
</script>
