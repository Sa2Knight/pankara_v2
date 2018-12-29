<!-- TODO VHistoryCardと共通部分(オンマウスにするとどうとか)どうにかしよ -->
<template>
  <div class="v-song-card" v-bind:class="{ hover: isMouseOver, 'elevation-12': isMouseOver }">
    <v-container @mouseenter="enter" @mouseleave="leave" grid-list-md text-xs-center>
      <a :href="getSongHref(song)">
        <div class="header">
          <h1 class="song-name collapse">{{ song.name }}</h1>
          <h2 v-if="showArtistName" class="artist-name collapse">{{ song.artist.name }}</h2>
        </div>
        <v-song-thumbnail :song="song" />
        <div class="histories-count-outer">
          <v-chip small color="primary" text-color="white">{{ song.histories_count }}回</v-chip>
          <v-chip small color="green" text-color="white">{{ song.histories_count_by_me }}回</v-chip>
        </div>
      </a>
    </v-container>
  </div>
</template>

<style lang="scss" scoped>
* {
  margin: 0;
  padding: 0;
}
h1.song-name {
  font-size: 1.2em;
  font-weight: bold;
}
h2.artist-name {
  font-size: 0.9em;
  font-weight: bold;
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
  import { ROUTES } from '../../lib/routes'
  export default {
    data: function() {
      return {
        isMouseOver: false
      }
    },
    props: {
      // 表示する楽曲オブジェクト
      song: {
        type: Object,
        required: true
      },
      // 歌手名を表示するか
      showArtistName: {
        type: Boolean,
        required: false,
        default: false
      }
    },
    methods: {
      // 楽曲詳細ページのurlを取得
      getSongHref: function() {
        return this.$router.resolve({
          name: 'Song',
          params: {
            id: this.song.id
          }
        }).href
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
