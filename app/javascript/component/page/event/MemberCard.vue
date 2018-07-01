<template>
  <div class="member-card">
    <div class="inner">
      <v-layout row wrap>
        <v-flex xs3>
          <div class="icon-wrapper">
            <div class="icon-inner">
              <img :src="member.user.image_url">
              <div class="display-name">{{ member.user.display_name }}</div>
            </div>
          </div>
        </v-flex>
        <v-flex xs9>
          <div class="comment arrow-box right">
            {{ comment }}
          </div>
        </v-flex>
      </v-layout>
    </div>
  </div>
</template>

<style lang="scss">
.member-card {
  margin: 5px;
  .inner {
    padding: 0 15px 0 15px;
    height: 100%;
    .icon-wrapper {
      height: 100%;
      text-align: center;
      .icon-inner {
        margin-top: 25%;
        img {
          width: auto;
          height: 48px;
          border-radius: 50%;
        }
      }
    }
    .comment {
      width: 100%;
      min-height: 96px;
    }
  }
}
</style>

<script>
  export default {
    props: {
      // comment, price, user{id, display_name, image_url}
      member: {
        type: Object,
        required: true
      },
    },
    computed: {
      comment: function() {
        return this.member.comment || '未入力'
      }
    },
  }
</script>
