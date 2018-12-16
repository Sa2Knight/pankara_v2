<template>
  <div class="v-history-card" v-bind:class="{ selected: isMouseOver, 'elevation-12': isMouseOver }">
    <a @click="select">
      <v-container class="outer" @mouseenter="enter" @mouseleave="leave" grid-list-md>
        <div class="thumbnail">
          <VSongThumbnail :song="history.song" />
        </div>
        <div class="description">
          <p v-if="showDate" class="date">
            {{ history.event.datetime }}
          </p>
          <p v-if="showEventTitle" class="collapse">
            {{ history.event.title }}
          </p>
          <p v-if="showSongName" class="song-name collapse">
            {{ history.song.name }}
          </p>
          <p v-if="showArtistName" class="artist-name collapse">
            {{ artistName }}
          </p>
          <span>
            キー: {{ history.key }}
          </span>
          <VSatisfactionRate narrow :satisfaction="history.satisfaction" />
          <VScoreLabel v-if="history.score" :score="history.score" />
          <VUserIcons :user="history.user" />
        </div>
      </v-container>
    </a>
  </div>
</template>

<style lang="scss">
.v-history-card .outer {
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
    max-width: 0px;
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
  import VSongThumbnail from '@component/common/VSongThumbnail'
  import VUserIcons from '@component/common/VUserIcons'
  import VScoreLabel from '@component/common/VScoreLabel'
  import VSatisfactionRate from '@component/common/VSatisfactionRate'
  const namespace = 'common'

  export default {
    components: {
      VSongThumbnail,
      VUserIcons,
      VScoreLabel,
      VSatisfactionRate
    },
    data: function() {
      return {
        isMouseOver: false
      }
    },
    props: {
      // 表示する歌唱履歴オブジェクト
      history: {
        type: Object,
        required: true
      },
      // 歌手情報(historyに含まれている場合は不要
      // NOTE: こういうの辞めたい
      artist: {
        type: Object,
        required: false
      },
      // 曲名を表示するか
      showSongName: {
        type: Boolean,
        required: false,
        default: false
      },
      // 歌手名を表示するか
      showArtistName: {
        type: Boolean,
        required: false,
        default: false
      },
      // 日付を表示するか
      showDate: {
        type: Boolean,
        required: false,
        default: false
      },
      // カラオケ名を表示するか
      showEventTitle: {
        type: Boolean,
        required: false,
        default: false
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
  }
</script>
