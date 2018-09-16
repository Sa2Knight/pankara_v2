<!-- TODO VHistoryCardと共通部分どうにかしよ -->
<template>
  <div class="v-song-card" v-bind:class="{ selected: isMouseOver, 'elevation-12': isMouseOver }">
    <v-container @click="select" @mouseenter="enter" @mouseleave="leave" grid-list-md text-xs-center>
      <v-layout row>
        <v-flex xs4>
          <v-song-thumbnail :song="song" />
        </v-flex>
        <v-flex xs8>
          <p class="song-name collapse">{{ song.name }}</p>
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<style lang="scss">
  .v-song-card {
    * {
      margin: 0;
      padding: 0;
    }
    &.selected {
      background-color: #feffcd;
    }
    p {
      font-weight: bold;
      &.song-name {
        font-size: 1.2em;
      }
      &.artist-name {
        font-size: 1.1em;
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
