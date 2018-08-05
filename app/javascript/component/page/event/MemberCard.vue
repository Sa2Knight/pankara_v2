<template>
  <div class="member-card">
    <div class="inner">
      <v-layout row wrap>
        <v-flex xs3>
          <v-user-icon :user="member.user" />
        </v-flex>
        <v-flex xs9>
          <div class="member-info arrow-box right">
            <div v-if="isShowComment">{{ comment }}</div>
            <div v-else>
              <div>歌唱数: {{ member.history_size }}</div>
              <div>最高点: {{ member.max_score}}</div>
              <div>平均点: {{ member.average_score}}</div>
            </div>
            <div class="buttons">
              <v-btn icon v-show="isShowComment" @click="">
                <v-icon>fas fa-pencil-alt</v-icon>
              </v-btn>
              <v-btn icon @click="swipeInfo">
                <v-icon>fas fa-exchange-alt</v-icon>
              </v-btn>
            </div>
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
    .member-info {
      position: relative;
      width: 100%;
      min-height: 100px;
      .buttons {
        position: absolute;
        right: 0px;
        bottom: 0px;
        .v-btn--icon {
          margin: 0px;
        }
        .v-icon {
          color: #ffd907;
        }
      }
    }
  }
}
</style>

<script>
  export default {
    data: function() {
      return {
        isShowComment: true
      }
    },
    props: {
      // comment, user{id, display_name, image_url}
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
    methods: {
      swipeInfo: function() {
        this.isShowComment = !this.isShowComment
      },
    },
    components: {
      VUserIcon: require('../../common/VUserIcon').default
    }
  }
</script>
