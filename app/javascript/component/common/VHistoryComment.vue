<template>
  <div class="v-history-comment">
    <v-layout row wrap>
      <v-flex xs3>
        <div class="user-icon">
          <v-user-icon :user="user" />
        </div>
      </v-flex>
      <v-flex xs9 class="comment-wrapper">
        <div class="comment arrow-box">
          {{ comment || defaultComment }}
        </div>
      </v-flex>
    </v-layout>
  </div>
</template>

<style lang="scss" scoped>
.v-history-comment {
  padding: 0 0.5em 0 0.5em;
  .comment-wrapper {
    position: relative;
    .comment {
      position: absolute;
      top: 0;
      bottom: 0;
    }
  }
}
</style>

<script>
  export default {
    props: {
      user: {
        type: Object,
        required: true
      },
      comment: {
        type: String,
        required: false,
      },
      defaultComment: {
        type: String,
        required: false,
        default: 'コメントなし',
      },
    },
    components: {
      VUserIcon: require('./VUserIcon').default,
    }
  }
</script>
