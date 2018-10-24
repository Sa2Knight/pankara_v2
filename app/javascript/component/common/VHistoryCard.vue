<template>
  <div class="v-history-card" v-bind:class="{ selected: isMouseOver, 'elevation-12': isMouseOver }">
    <v-container @click="select" class="outer" @mouseenter="enter" @mouseleave="leave" grid-list-md>
      <div class="thumbnail">
        <v-song-thumbnail :song="history.song" />
      </div>
      <div class="description">
        <p class="song-name collapse">{{ history.song.name }}</p>
        <p class="artist-name collapse">{{ artistName }}</p>
        <span>キー: {{ history.key }}</span>
        <span>満足度: {{ history.satisfaction }}</span>
        <v-score-label v-if="history.score" :score="history.score" />
        <v-user-icons :user="history.user" />
      </div>
    </v-container>
  </div>
</template>

<style lang="scss" scoped>
.outer {
  position: relative;
  display: table;
  &.selected {
    background-color: #feffcd;
  }
  p {
    font-weight: bold;
    padding: 0;
    margin: 0;
    &.song-name {
      font-size: 1.2em;
    }
    &.artist-name {
      font-size: 1.1em;
    }
  }
  .thumbnail {
    width: 150px;
    min-width: 150px;
    display: table-cell;
  }
  .description {
    display: table-cell;
    vertical-align: middle;
    padding-left: 1em;
    .v-score-label {
      position: absolute;
      right: 3px;
      top: 5px;
    }
    .v-user-icons {
      position: absolute;
      right: 2px;
      bottom: 5px;
    }
  }
}
</style>

<script>
  import { mapActions } from 'vuex'
  import ROUTES from '../../lib/routes'
  import Util from '../../lib/util'
  const namespace = 'common'

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
     },
    },
    methods: {
      ...mapActions(namespace, [
        'showHistoryDialog'
      ]),
      // 歌唱履歴詳細ダイアログを開く
      select: function() {
        this.showHistoryDialog(this.history.id)
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
      VUserIcons: require('./VUserIcons').default,
      VScoreLabel: require('./VScoreLabel').default
    }
  }
</script>
