<!-- TODO VHistoryCardと共通部分(オンマウスにするとどうとか)どうにかしよ -->
<template>
  <div class="v-song-card" v-bind:class="{ hover: isMouseOver, 'elevation-12': isMouseOver }">
    <v-container @click="select" @mouseenter="enter" @mouseleave="leave" grid-list-md text-xs-center>
      <div class="header">
        <div class="song-name collapse">{{ song.name }}</div>
      </div>
      <v-song-thumbnail :song="song" />
      <div class="histories-count-outer">
        <v-chip small color="primary" text-color="white">{{ song.histories_count }}回</v-chip>
        <v-chip small color="green" text-color="white">{{ song.histories_count_by_me }}回</v-chip>
      </div>
    </v-container>
  </div>
</template>

<style lang="scss" scoped>
* {
  margin: 0;
  padding: 0;
}
.song-name {
  font-size: 1.2em;
}
.hover {
  background-color: #feffcd;
}
.v-song-thumbnail {
  img {
    max-width: 100%;
    max-height: 100%;
  }
}
.histories-count-outer {
  > * {
    height: 1.2em;
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
