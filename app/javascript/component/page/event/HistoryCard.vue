<template>
  <div class="history-card" v-bind:class="{ selected: isSelected, 'elevation-12': isSelected }">
    <v-container @click="select" grid-list-md text-xs-center>
      <v-layout row>
        <v-flex xs4>
          <v-song-thumbnail :song="history.song" />
        </v-flex>
        <v-flex xs7>
          <p class="song-name collapse">{{ history.song.name }}</p>
          <p class="artist-name collapse">{{ history.song.artist.name }}</p>
          <span>キー: {{ history.key }}</span>
          <span>満足度: {{ history.satisfaction }}</span>
          <span>得点: {{ history.score }}</span>
        </v-flex>
        <v-flex xs1 class="right-column">
          <v-user-icons :user="history.user" />
        </v-flex>
      </v-layout>
      <v-layout row justify-space-around v-show="isSelected">
        <v-btn icon>
          <v-icon>fas fa-clipboard-list</v-icon>
        </v-btn>
        <v-btn icon>
          <v-icon>fas fa-pencil-alt</v-icon>
        </v-btn>
        <v-btn icon>
          <v-icon>fas fa-trash-alt</v-icon>
        </v-btn>
        <v-menu bottom left>
          <v-btn slot="activator" icon>
            <v-icon>fas fa-ellipsis-h</v-icon>
          </v-btn>
          <v-list>
            <v-list-tile @click="showYoutubeDialog">
              <v-list-tile-title>動画再生</v-list-tile-title>
            </v-list-tile>
            <v-list-tile>
              <v-list-tile-title>楽曲詳細</v-list-tile-title>
            </v-list-tile>
            <v-list-tile>
              <v-list-tile-title>歌手詳細</v-list-tile-title>
            </v-list-tile>
          </v-list>
        </v-menu>
      </v-layout>
    </v-container>
  </div>
</template>

<style lang="scss">
  .history-card {
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
  export default {
    data: function() {
      return {

      }
    },
    props: {
      history: {
        type: Object,
        required: true
      }
    },
    computed: {
      isSelected: function() {
        return this.history.id == this.selectedHistoryId
      },
      ...mapState({
        selectedHistoryId: state => state.event.selectedHistoryId
      })
    },
    methods: {
      // 特定の歌唱履歴を選択状態にする
      select: function() {
        this.$store.dispatch('selectHistory', this.history.id)
      },
      // 特定の歌唱履歴の楽曲のYoutubeダイアログを表示する
      showYoutubeDialog: function() {
        this.$store.dispatch('showYoutubeDialog', this.history.song)
      },
    },
    components: {
      VSongThumbnail: require('../../common/VSongThumbnail').default,
      VUserIcons: require('../../common/VUserIcons').default,
    }
  }
</script>
