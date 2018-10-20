<!-- TODO VHistoryCardと共通部分(オンマウスにするとどうとか)どうにかしよ -->
<template>
  <div class="v-song-card" v-bind:class="{ selected: isMouseOver, 'elevation-12': isMouseOver }">
    <v-container @click="select" @mouseenter="enter" @mouseleave="leave" grid-list-md text-xs-center>
      <v-layout row>
        <v-flex xs4>
          <v-song-thumbnail :song="song" />
        </v-flex>
        <v-flex xs8 class="song-detail">
          <div class="song-name collapse">{{ song.name }}</div>
          <div class="histories-count-outer">
            <v-chip small color="green" text-color="white">
              <v-avatar class="green darken-4">{{ song.histories_count }}回</v-avatar>全体
            </v-chip>
            <v-chip small color="blue" text-color="white">
              <v-avatar class="blue darken-4">{{ song.histories_count_by_me }}回</v-avatar>自分
            </v-chip>
          </div>
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<style lang="scss" scoped>
* {
  margin: 0;
  padding: 0;
}
.selected {
  background-color: #feffcd;
}
.song-detail {
  position: relative;
  .song-name {
    font-weight: bold;
    font-size: 1.5em;
  }
}
.v-song-thumbnail {
  img {
    max-width: 100%;
    max-height: 100%;
  }
}
.right-column {
  position: relative;
  .v-user-icons {
    position: absolute;
    right: 0;
    bottom: 0;
  }
}
</style>

<script>
  import { mapState } from 'vuex'
  import ROUTES from '../../lib/routes'
  export default {
    data: function() {
      return {
        isMouseOver: false
      }
    },
    props: {
      song: {
        type: Object,
        required: true
      },
    },
    methods: {
      // 楽曲詳細ページへリンク
      select: function() {
        this.$router.push(ROUTES.SONG_PATH(this.song.id))
      },
      // オンマウス状態にする
      enter: function() {
        this.isMouseOver = true
      },
      // オンマウス状態を解除する
      leave: function() {
        this.isMouseOver = false
      }
    },
    components: {
      VSongThumbnail: require('./VSongThumbnail').default,
    }
  }
</script>
