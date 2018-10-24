<!-- コンポーネント名が不適切? -->
<template>
  <div class="outer">
    <div class="inner">
      <v-layout row wrap>
        <v-flex xs3>
          <v-user-icon :user="member.user" />
        </v-flex>
        <v-flex xs9>
          <div class="member-info arrow-box right">
            <div>歌唱数: {{ member.history_size }}</div>
            <div>最高点: {{ max_score}}</div>
            <div>平均点: {{ average_score}}</div>
          </div>
        </v-flex>
      </v-layout>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.outer {
  margin: 5px;
  .inner {
    padding: 0 0.5em 0 0.5em;
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
  import Util from '../../../../lib/util'
  export default {
    data: function() {
      return {
        isShowComment: true
      }
    },
    props: {
      // user{id, display_name, image_url}
      member: {
        type: Object,
        required: true
      },
    },
    computed: {
      max_score: function() {
        return Util.round(this.member.max_score, 2)
      },
      average_score: function() {
        return Util.round(this.member.average_score, 2)
      }
    },
    components: {
      VUserIcon: require('../../../common/VUserIcon').default
    }
  }
</script>
