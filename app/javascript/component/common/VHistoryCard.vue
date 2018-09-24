<template>
  <div class="v-history-card" v-bind:class="{ selected: isMouseOver, 'elevation-12': isMouseOver }">
    <v-container @click="select" @mouseenter="enter" @mouseleave="leave" grid-list-md text-xs-center>
      <v-layout row>
        <v-flex xs4>
          <v-song-thumbnail :song="history.song" />
        </v-flex>
        <v-flex xs7>
          <p class="song-name collapse">{{ history.song.name }}</p>
          <p class="artist-name collapse">{{ artistName }}</p>
          <span>キー: {{ history.key }}</span>
          <span>満足度: {{ history.satisfaction }}</span>
          <span>得点: {{ history.score }}</span>
        </v-flex>
        <v-flex xs1 class="right-column">
          <v-user-icons :user="history.user" />
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<style lang="scss">
  .v-history-card {
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
      history: {
        type: Object,
        required: true
      },
      artist: { // historyに含まれている場合不要
        type: Object,
        required: false
      }
    },
    computed: {
      artistName: function() {
        return this.artist ? this.artist.name : this.history.song.artist.name
      }
    },
    methods: {
      // 歌唱履歴詳細ダイアログを開く
      select: function() {
        this.$store.dispatch('showHistoryDialog', this.history.id)
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
      VUserIcons: require('./VUserIcons.vue').default,
    }
  }
</script>
